// Minimal example: build the INIT sequence, parse a hypothetical event frame.
//
// To use over real BLE you'd plug `WhoopFrame.buildCommand` outputs into a
// `writeCharacteristic` call and feed received bytes into `FrameReassembler`.

import 'dart:typed_data';
import 'package:whoopsie_protocol/whoopsie_protocol.dart';

void main() {
  // Build the 5-packet HCI-snoop INIT.
  print('INIT sequence:');
  for (var i = 0; i < kInitPackets.length; i++) {
    print('  [${i + 1}/5] ${_hex(kInitPackets[i])}');
  }

  // Re-derive packet 0 from the builder to prove they match.
  final hello = WhoopFrame.buildCommand(0, WhoopCmd.getHelloHarvard, []);
  print('\nGET_HELLO via builder: ${_hex(hello)}');

  // Build a battery-poll command at seq 0xA0.
  final batt = WhoopFrame.buildCommand(0xA0, WhoopCmd.getBatteryLevel, []);
  print('GET_BATTERY_LEVEL:     ${_hex(batt)}');

  // Build a sync ACK with a fake 8-byte token at counter 5.
  final ack =
      WhoopFrame.buildBatchAck(5, List<int>.filled(8, 0xAA));
  print('Sync ACK (counter=5):   ${_hex(ack)}');
}

String _hex(Uint8List b) => b.map((x) => x.toRadixString(16).padLeft(2, '0')).join(' ');
