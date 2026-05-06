/// WHOOP 4.0 command opcodes carried at `inner_payload[2]` of a 0x23 packet.
///
/// Subset that's actually useful for app-side clients. Full enum (75 opcodes)
/// is in the JADX-decompiled `im0/EnumC25523e.java`.
class WhoopCmd {
  static const int linkValid = 0x01;
  static const int toggleHr = 0x03;
  static const int abortHistorical = 0x14;
  static const int sendHistorical = 0x16;
  static const int historicalDataResult = 0x17; // sync ACK
  static const int getBatteryLevel = 0x1A;
  static const int reboot = 0x1D;
  static const int getDataRange = 0x22;
  static const int getHelloHarvard = 0x23;
  static const int shipMode = 0x37;
  static const int sendR10R11Realtime = 0x3F;
  static const int setAlarmTime = 0x42;
  static const int getAlarmTime = 0x43;
  static const int getAdvertisingName = 0x4C;
  static const int setAdvertisingName = 0x4D;
  static const int runHapticsPattern = 0x4F;
  static const int enterHighFreqSync = 0x60;
  static const int exitHighFreqSync = 0x61;
  static const int toggleImuMode = 0x6A;
  static const int enableOpticalData = 0x6B;
  static const int toggleOpticalMode = 0x6C;
  static const int stopHaptics = 0x7A;
  static const int selectWrist = 0x7B;
  static const int togglePersistentR21 = 0x9A;
  static const int shipOff = 0xCC;
}
