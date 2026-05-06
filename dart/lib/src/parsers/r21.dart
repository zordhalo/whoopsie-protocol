import 'dart:typed_data';
import '../types.dart';

/// Parse R21 (6-channel raw optical waveforms, 1244 bytes).
///
/// We extract a single representative sample per channel (the first uint16);
/// the full 100-sample waveforms are at the same offsets if you want them.
PpgSample? parseR21(Uint8List p) {
  if (p.length < 622) return null;
  final bd = ByteData.sublistView(p);
  final ts = bd.getUint32(7, Endian.little);
  final ledDrive = bd.getUint16(14, Endian.little);
  final g1 = bd.getUint16(20, Endian.little);
  final g2 = bd.getUint16(220, Endian.little);
  final ir = bd.getUint16(420, Endian.little);
  final d = p.length >= 832 ? bd.getUint16(632, Endian.little) : null;
  final e = p.length >= 1032 ? bd.getUint16(832, Endian.little) : null;
  final red = p.length >= 1234 ? bd.getUint16(1032, Endian.little) : 0;
  int? spo2;
  if (ir > 1000 && red > 100) {
    spo2 = (110 - 25 * (red / ir)).round().clamp(85, 100);
  }
  return PpgSample(
    ts: DateTime.fromMillisecondsSinceEpoch(ts * 1000, isUtc: true),
    ledDrive: ledDrive,
    g1: g1,
    g2: g2,
    ir: ir,
    red: red,
    d: d,
    e: e,
    spo2: spo2,
  );
}
