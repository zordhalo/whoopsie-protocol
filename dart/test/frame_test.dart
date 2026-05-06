import 'package:test/test.dart';
import 'package:whoopsie_protocol/whoopsie_protocol.dart';

void main() {
  test('GET_HELLO matches HCI-snoop verbatim', () {
    final built = WhoopFrame.buildCommand(0x00, 0x23, []);
    expect(built, equals(kInitPackets[0]));
  });

  test('CRC8 of length [0x08, 0x00] = 0xA8', () {
    expect(crc8([0x08, 0x00]), equals(0xA8));
  });

  test('reassembler joins fragments', () {
    final r = FrameReassembler();
    final f = kInitPackets[0];
    expect(r.feed(f.sublist(0, 4)), isEmpty);
    final out = r.feed(f.sublist(4));
    expect(out, hasLength(1));
    expect(out.first, equals(f));
  });

  test('batch ACK has correct length and shape', () {
    final ack = WhoopFrame.buildBatchAck(5, List.filled(8, 0xAB));
    expect(ack.length, equals(20));
    expect(ack[0], equals(0xAA));
    expect(ack[6], equals(0x17));
    expect(ack[7], equals(0x01));
  });
}
