import 'dart:typed_data';
import '../events.dart';
import '../types.dart';

DateTime _ts(int sec) {
  if (sec <= 0 || sec > 4000000000) return DateTime.now();
  return DateTime.fromMillisecondsSinceEpoch(sec * 1000, isUtc: true);
}

/// Parse a 0x30 EVENT inner payload.
WhoopEvent? parseEvent(Uint8List p) {
  if (p.length < 8) return null;
  final bd = ByteData.sublistView(p);
  final id = bd.getUint16(2, Endian.little);
  final ts = _ts(bd.getUint32(4, Endian.little));
  String detail = '';
  if (id == WhoopEventId.temperature && p.length >= 15) {
    detail = '${(bd.getInt16(13, Endian.little) / 10.0).toStringAsFixed(1)}°C';
  } else if (id == WhoopEventId.packInfo && p.length >= 21) {
    final ascii =
        p.sublist(13, 21).where((b) => b > 0x20 && b < 0x7F).toList();
    detail = String.fromCharCodes(ascii);
  }
  return WhoopEvent(ts: ts, id: id, name: eventName(id), detail: detail);
}
