import 'dart:typed_data';

/// Parse the GET_BATTERY_LEVEL (0x1A) response.
///
/// Format (after the 0x24 frame is unwrapped to inner_payload):
///   payload[0] = 0x24
///   payload[1] = seq
///   payload[2] = 0x1A (echoed)
///   payload[5..7] = uint16 LE × 10
///
/// We poll this every 20s instead of trusting the BATTERY_LEVEL event,
/// whose payload format is not stable across firmware revisions.
double? parseBatteryResponse(Uint8List innerPayload) {
  if (innerPayload.length < 7) return null;
  if (innerPayload[2] != 0x1A) return null;
  final raw = ByteData.sublistView(innerPayload).getUint16(5, Endian.little);
  final pct = raw / 10.0;
  if (pct <= 0 || pct > 100) return null;
  return pct;
}
