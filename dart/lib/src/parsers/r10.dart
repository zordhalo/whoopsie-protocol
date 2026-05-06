import 'dart:typed_data';
import '../types.dart';

/// Parse R10 (1Hz HR + IMU + GSR snapshot, 1928 bytes when fully populated).
HrSample? parseR10(Uint8List p) {
  if (p.length < 694) return null;
  final bd = ByteData.sublistView(p);
  final ts = bd.getUint32(7, Endian.little);
  return HrSample(
    ts: DateTime.fromMillisecondsSinceEpoch(ts * 1000, isUtc: true),
    hr: p[17],
    accelX: bd.getInt16(85, Endian.little),
    accelY: bd.getInt16(87, Endian.little),
    accelZ: bd.getInt16(89, Endian.little),
    gyroX: bd.getInt16(688, Endian.little),
    gyroY: bd.getInt16(690, Endian.little),
    gyroZ: bd.getInt16(692, Endian.little),
    gsr: bd.getUint16(154, Endian.little),
  );
}
