import 'dart:typed_data';
import '../types.dart';

/// Parse R24 (recovery summary).
RecoverySummary? parseR24(Uint8List p) {
  if (p.length < 91) return null;
  final bd = ByteData.sublistView(p);
  return RecoverySummary(
    ts: DateTime.fromMillisecondsSinceEpoch(
        bd.getUint32(7, Endian.little) * 1000,
        isUtc: true),
    score: bd.getFloat32(41, Endian.little).clamp(0.0, 1.0),
    hrvMs: bd.getUint16(85, Endian.little) / 10.0,
    respRatePerMin: bd.getUint16(87, Endian.little) / 1000.0,
    skinTempDeltaC: bd.getInt16(89, Endian.little) / 100.0,
  );
}
