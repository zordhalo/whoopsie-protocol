import 'dart:typed_data';
import '../types.dart';

/// Detect a sync batch marker (0x31 METADATA, sub-type 0x02 HISTORY_END) and
/// return the 8-byte token to ACK with `WhoopFrame.buildBatchAck`.
///
/// The exact wire form we recognize: `aa1c00ab31...` (28-byte total length).
BatchToken? parseBatchMarker(Uint8List frame) {
  if (frame.length < 25) return null;
  if (frame[0] != 0xAA ||
      frame[1] != 0x1C ||
      frame[2] != 0x00 ||
      frame[3] != 0xAB ||
      frame[4] != 0x31) {
    return null;
  }
  return BatchToken(Uint8List.sublistView(frame, 17, 25));
}
