import 'dart:typed_data';
import '../types.dart';

/// Parse R2 (compressed PPG point samples — used in low-bandwidth modes).
PpgSample? parseR2(Uint8List p) {
  if (p.length < 13) return null;
  final bd = ByteData.sublistView(p);
  final ir = bd.getUint16(7, Endian.big);
  final grn = bd.getUint16(9, Endian.big);
  final red = bd.getUint16(11, Endian.big);
  int? spo2;
  if (ir > 1000 && red > 100) {
    spo2 = (110 - 25 * (red / ir)).round().clamp(85, 100);
  }
  // Timestamp lives at p[3..7] in this compact format.
  final tsSec = bd.getUint32(3, Endian.little);
  return PpgSample(
    ts: DateTime.fromMillisecondsSinceEpoch(tsSec * 1000, isUtc: true),
    ledDrive: 0,
    g1: grn,
    g2: 0,
    ir: ir,
    red: red,
    spo2: spo2,
  );
}
