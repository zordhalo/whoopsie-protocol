import 'dart:typed_data';

/// Identity returned by GET_HELLO_HARVARD.
class WhoopIdentity {
  final String serial;
  final String firmware;
  final String hardware;
  final double batteryPct;
  final bool charging;
  final DateTime deviceTime;
  final WristState wrist;

  const WhoopIdentity({
    required this.serial,
    required this.firmware,
    required this.hardware,
    required this.batteryPct,
    required this.charging,
    required this.deviceTime,
    required this.wrist,
  });
}

enum WristState { unknown, on, off }

/// 1Hz biometrics + IMU snapshot from R10.
class HrSample {
  final DateTime ts;
  final int hr;
  final int accelX, accelY, accelZ;
  final int gyroX, gyroY, gyroZ;
  final int gsr;
  const HrSample({
    required this.ts,
    required this.hr,
    required this.accelX,
    required this.accelY,
    required this.accelZ,
    required this.gyroX,
    required this.gyroY,
    required this.gyroZ,
    required this.gsr,
  });
}

/// 6-channel optical sample from R21 (or compressed R2).
class PpgSample {
  final DateTime ts;
  final int ledDrive;
  final int g1, g2, ir, red;
  final int? d, e;
  final int? spo2;
  const PpgSample({
    required this.ts,
    required this.ledDrive,
    required this.g1,
    required this.g2,
    required this.ir,
    required this.red,
    this.d,
    this.e,
    this.spo2,
  });
}

/// Recovery summary from R24.
class RecoverySummary {
  final DateTime ts;
  final double score; // 0..1
  final double hrvMs;
  final double respRatePerMin;
  final double skinTempDeltaC;
  const RecoverySummary({
    required this.ts,
    required this.score,
    required this.hrvMs,
    required this.respRatePerMin,
    required this.skinTempDeltaC,
  });
}

/// RR-interval time series from R25.
class RrSample {
  final DateTime ts;
  final List<int> rrDiffsMs;
  final double rmssdMs;
  const RrSample({
    required this.ts,
    required this.rrDiffsMs,
    required this.rmssdMs,
  });
}

/// Strap event.
class WhoopEvent {
  final DateTime ts;
  final int id;
  final String name;
  final String detail;
  const WhoopEvent({
    required this.ts,
    required this.id,
    required this.name,
    required this.detail,
  });
}

/// Sync ACK token extracted from a 0x31 metadata marker.
class BatchToken {
  final Uint8List bytes; // 8 bytes
  const BatchToken(this.bytes);
}
