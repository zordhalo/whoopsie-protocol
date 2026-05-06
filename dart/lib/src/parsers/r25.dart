import 'dart:math' as math;
import 'dart:typed_data';
import '../types.dart';

/// Parse R25 (RR-interval differentials, ms).
RrSample? parseR25(Uint8List p) {
  if (p.length < 17) return null;
  final bd = ByteData.sublistView(p);
  final tsSec = bd.getUint32(7, Endian.little);
  final diffs = <int>[];
  for (int i = 15; i + 1 < p.length; i += 2) {
    diffs.add(bd.getInt16(i, Endian.little));
  }
  if (diffs.isEmpty) return null;
  double sumSq = 0;
  for (final v in diffs) {
    sumSq += v * v;
  }
  return RrSample(
    ts: DateTime.fromMillisecondsSinceEpoch(tsSec * 1000, isUtc: true),
    rrDiffsMs: diffs,
    rmssdMs: math.sqrt(sumSq / diffs.length),
  );
}
