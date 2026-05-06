import 'dart:typed_data';
import 'crc.dart';

/// Packet type codes carried at `inner_payload[0]`.
class PktType {
  static const int command = 0x23;
  static const int response = 0x24;
  static const int realtime = 0x28;
  static const int realtimeRaw = 0x2B;
  static const int historical = 0x2F;
  static const int event = 0x30;
  static const int metadata = 0x31;
  static const int fwLog = 0x32;
}

/// Build/parse the wire frame:
///
///   [0xAA] [len_lo len_hi] [crc8] [inner (4-byte padded)] [crc32]
///
class WhoopFrame {
  /// Build a COMMAND packet (`type=0x23`) wrapping `cmd` + payload.
  static Uint8List buildCommand(int seq, int cmd, [List<int>? payload]) {
    final p = payload ?? const <int>[];
    final innerLen = 3 + p.length;
    final padded = innerLen + ((-innerLen) % 4);
    final inner = Uint8List(padded);
    inner[0] = PktType.command;
    inner[1] = seq & 0xFF;
    inner[2] = cmd & 0xFF;
    for (int i = 0; i < p.length; i++) {
      inner[3 + i] = p[i] & 0xFF;
    }
    return _wrap(inner);
  }

  /// Sync ACK in the wire-observed 12-byte form:
  ///   `aa10005723 [counter] 1701 [batchN_8B] [crc32]`
  static Uint8List buildBatchAck(int counter, List<int> batchN) {
    if (batchN.length != 8) {
      throw ArgumentError('batchN must be 8 bytes, got ${batchN.length}');
    }
    final body = <int>[0xAA, 0x10, 0x00, 0x57, 0x23, counter & 0xFF, 0x17, 0x01]
      ..addAll(batchN);
    final inner = body.sublist(4);
    final c = crc32(inner);
    return Uint8List.fromList([
      ...body,
      c & 0xFF,
      (c >> 8) & 0xFF,
      (c >> 16) & 0xFF,
      (c >> 24) & 0xFF,
    ]);
  }

  /// Strip the framing — returns the inner payload (4-byte padded).
  /// Returns null if the frame is malformed.
  static Uint8List? unwrap(Uint8List frame) {
    if (frame.length < 9 || frame[0] != 0xAA) return null;
    final len = frame[1] | (frame[2] << 8);
    if (frame.length != 4 + len) return null;
    return Uint8List.sublistView(frame, 4, frame.length - 4);
  }

  static Uint8List _wrap(Uint8List inner) {
    final length = inner.length + 4;
    final out = Uint8List(4 + inner.length + 4);
    out[0] = 0xAA;
    out[1] = length & 0xFF;
    out[2] = (length >> 8) & 0xFF;
    out[3] = crc8([out[1], out[2]]);
    out.setRange(4, 4 + inner.length, inner);
    final c = crc32(inner);
    final off = 4 + inner.length;
    out[off] = c & 0xFF;
    out[off + 1] = (c >> 8) & 0xFF;
    out[off + 2] = (c >> 16) & 0xFF;
    out[off + 3] = (c >> 24) & 0xFF;
    return out;
  }
}

/// Reassembles framed packets from a stream of BLE notification chunks.
/// One instance per characteristic — each notify char has its own packet
/// boundary semantics on the wire.
class FrameReassembler {
  final BytesBuilder _buf = BytesBuilder();

  List<Uint8List> feed(List<int> incoming) {
    if (incoming.isNotEmpty && incoming[0] == 0xAA) {
      // Start-of-frame marker — anything in the buffer was a partial we missed.
      _buf.clear();
    }
    _buf.add(incoming);
    final out = <Uint8List>[];
    while (true) {
      final bytes = _buf.toBytes();
      if (bytes.length < 4 || bytes[0] != 0xAA) break;
      final total = 4 + (bytes[1] | (bytes[2] << 8));
      if (bytes.length < total) break;
      out.add(Uint8List.fromList(bytes.sublist(0, total)));
      // Strip leading nulls between frames.
      int i = total;
      while (i < bytes.length && bytes[i] == 0) {
        i++;
      }
      _buf.clear();
      if (i < bytes.length) _buf.add(bytes.sublist(i));
    }
    return out;
  }

  void reset() => _buf.clear();
}
