/// WHOOP 4.0 (Harvard / Puffin) BLE protocol library for Dart.
///
/// Provides:
/// - BLE service / characteristic UUIDs
/// - Frame builder + reassembler (CRC8 + CRC32, 4-byte padding)
/// - HCI-snoop verbatim INIT packets
/// - Sync ACK builder (12-byte wire form)
/// - Parsers for R10, R21, R2, R24, R25, events, HELLO, battery
/// - Command opcodes + event id tables
///
/// See `package:whoopsie_protocol/whoopsie_protocol.dart` exports below.
library;

export 'src/uuids.dart';
export 'src/crc.dart';
export 'src/frame.dart';
export 'src/init.dart';
export 'src/commands.dart';
export 'src/events.dart';
export 'src/types.dart';
export 'src/parsers/event.dart';
export 'src/parsers/hello.dart';
export 'src/parsers/r10.dart';
export 'src/parsers/r21.dart';
export 'src/parsers/r2.dart';
export 'src/parsers/r24.dart';
export 'src/parsers/r25.dart';
export 'src/parsers/battery.dart';
export 'src/parsers/sync.dart';
