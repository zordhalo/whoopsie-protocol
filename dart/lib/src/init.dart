import 'dart:typed_data';

/// HCI-snoop verbatim 5-packet INIT sequence captured from the official
/// Android app. Sequences 0..4 with pre-computed CRCs. Send these in order,
/// advancing on each `didWriteValue` callback.
final List<Uint8List> kInitPackets = [
  _hex('aa0800a823002300ada86a2d'), // GET_HELLO_HARVARD
  _hex('aa0800a823014c00f2b5cdce'), // GET_ADVERTISING_NAME
  _hex('aa0800a823022200824df537'), // GET_DATA_RANGE
  _hex('aa0800a823034301c54dd63d'), // GET_ALARM_TIME
  _hex('aa0800a823041600c7c25288'), // SEND_HISTORICAL_DATA
];

Uint8List _hex(String s) {
  final out = Uint8List(s.length ~/ 2);
  for (int i = 0; i < out.length; i++) {
    out[i] = int.parse(s.substring(i * 2, i * 2 + 2), radix: 16);
  }
  return out;
}
