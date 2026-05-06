# whoopsie_protocol (Dart)

Pure-Dart implementation of the [WHOOP 4.0 BLE protocol](../WHOOP_BLE_PROTOCOL.md).

```yaml
dependencies:
  whoopsie_protocol:
    git:
      url: https://github.com/project-whoopsie/whoopsie-protocol.git
      path: dart
```

```dart
import 'package:whoopsie_protocol/whoopsie_protocol.dart';

// Build commands
final hello = WhoopFrame.buildCommand(0, WhoopCmd.getHelloHarvard);
final batt  = WhoopFrame.buildCommand(0xA0, WhoopCmd.getBatteryLevel);
final ack   = WhoopFrame.buildBatchAck(5, batchToken8Bytes);

// Parse incoming
final reasm = FrameReassembler();
for (final frame in reasm.feed(rawBleNotifyChunk)) {
  final p = WhoopFrame.unwrap(frame);
  if (p == null) continue;
  switch (p[0]) {
    case PktType.event:        parseEvent(p);
    case PktType.realtime:
    case PktType.historical:   parseR10(p) ?? parseR21(p) ?? parseR2(p);
    case PktType.response:     parseHello(Uint8List.sublistView(p, 3));
  }
}
```

## What's covered

- `WhoopsieUuids` — service + characteristic UUIDs (Harvard)
- `WhoopFrame.buildCommand`, `.buildBatchAck`, `.unwrap`
- `FrameReassembler` — handles fragmented BLE notifies
- `kInitPackets` — verbatim 5-packet HCI-snoop INIT
- `WhoopCmd` — command opcodes
- `WhoopEventId`, `kEventNames`, `eventName(id)` — event taxonomy
- Parsers: `parseEvent`, `parseHello`, `parseR10`, `parseR21`, `parseR2`, `parseR24`, `parseR25`, `parseBatteryResponse`, `parseBatchMarker`
- Public types: `WhoopIdentity`, `HrSample`, `PpgSample`, `RecoverySummary`, `RrSample`, `WhoopEvent`, `BatchToken`

## Not covered (use the parent doc)

The transport layer — actual BLE scanning, bonding, GATT writes — is left to your platform package of choice (`flutter_blue_plus`, etc.). This package is wire-format only.

## Running tests

```bash
cd dart
dart pub get
dart test
```

## Running the example

```bash
dart run example/main.dart
```

## License

AGPL-3.0
