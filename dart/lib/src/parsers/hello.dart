import 'dart:typed_data';
import '../types.dart';

/// Parse the body of a HELLO_HARVARD response (`payload[3:]` after stripping
/// type/seq/cmd from a 0x24 packet whose echoed cmd is 0x23).
WhoopIdentity? parseHello(Uint8List body) {
  if (body.length < 115) return null;
  final hwHint = body[0];
  final t = hwHint == 4 ? 1 : 0;
  final battRaw = ByteData.sublistView(body).getInt32(1, Endian.little);
  final tsSec = ByteData.sublistView(body).getUint32(6, Endian.little);
  final serial = body
      .sublist(14, 23)
      .map((b) => b.toRadixString(16).padLeft(2, '0'))
      .join();
  final hw = body
      .sublist(77 + t, 81 + t)
      .map((b) => b.toRadixString(16).padLeft(2, '0'))
      .join();
  final fw = body
      .sublist(89 + t, 97 + t)
      .map((b) => b.toRadixString(16).padLeft(2, '0'))
      .join();
  final wristByte = body.length > 113 + t ? body[113 + t] : 0;
  final wrist = switch (wristByte) {
    1 => WristState.on,
    2 => WristState.off,
    _ => WristState.unknown,
  };
  return WhoopIdentity(
    serial: serial,
    firmware: fw,
    hardware: hw,
    batteryPct: battRaw / 10.0,
    charging: body[5] != 0,
    deviceTime: DateTime.fromMillisecondsSinceEpoch(tsSec * 1000, isUtc: true),
    wrist: wrist,
  );
}
