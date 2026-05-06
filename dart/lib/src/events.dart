/// Strap event ids carried at `inner_payload[2..4]` (uint16 LE) of a 0x30 EVENT packet.
class WhoopEventId {
  static const int error = 1;
  static const int console = 2;
  static const int batteryLevel = 3;
  static const int sysCtrl = 4;
  static const int chargingOn = 7;
  static const int chargingOff = 8;
  static const int wristOn = 9;
  static const int wristOff = 10;
  static const int bleUp = 11;
  static const int bleDown = 12;
  static const int rtcLost = 13;
  static const int doubleTap = 14;
  static const int boot = 15;
  static const int setRtc = 16;
  static const int temperature = 17;
  static const int pairingMode = 18;
  static const int packAttached = 21;
  static const int packRemoved = 22;
  static const int bleBonded = 23;
  static const int hrProfileOn = 24;
  static const int hrProfileOff = 25;
  static const int flashInit = 28;
  static const int strapCondition = 29;
  static const int capAuto = 32;
  static const int hrOn = 33;
  static const int hrOff = 34;
  static const int accReset = 35;
  static const int afeReset = 36;
  static const int optSat1 = 40;
  static const int optSat2 = 41;
  static const int alarmSet = 56;
  static const int alarmExec = 57;
  static const int alarmDisabled = 59;
  static const int hapticFire = 60;
  static const int extBattery = 63;
  static const int hiSyncPrompt = 96;
  static const int hiSyncOn = 97;
  static const int hiSyncOff = 98;
  static const int hapticDone = 100;
  static const int ppgSearchOn = 102;
  static const int ppgSearchOff = 103;
  static const int packInfo = 109;
}

/// Human-readable names for known event ids.
const Map<int, String> kEventNames = {
  1: 'ERROR', 2: 'CONSOLE', 3: 'BATTERY', 4: 'SYS_CTRL',
  7: 'CHARGING_ON', 8: 'CHARGING_OFF', 9: 'WRIST_ON', 10: 'WRIST_OFF',
  11: 'BLE_UP', 12: 'BLE_DOWN', 13: 'RTC_LOST', 14: 'DOUBLE_TAP',
  15: 'BOOT', 16: 'SET_RTC', 17: 'TEMPERATURE', 18: 'PAIRING_MODE',
  21: 'PACK_ATTACHED', 22: 'PACK_REMOVED', 23: 'BLE_BONDED',
  24: 'HR_PROF_ON', 25: 'HR_PROF_OFF',
  28: 'FLASH_INIT', 29: 'STRAP_CONDITION',
  32: 'CAP_AUTO', 33: 'HR_ON', 34: 'HR_OFF',
  35: 'ACC_RESET', 36: 'AFE_RESET',
  40: 'OPT_SAT_1', 41: 'OPT_SAT_2',
  56: 'ALARM_SET', 57: 'ALARM_EXEC', 59: 'ALARM_DIS',
  60: 'HAPTIC_FIRE', 63: 'EXT_BATTERY',
  96: 'HI_SYNC_PROMPT', 97: 'HI_SYNC_ON', 98: 'HI_SYNC_OFF',
  100: 'HAPTIC_DONE',
  102: 'PPG_SEARCH_ON', 103: 'PPG_SEARCH_OFF',
  109: 'PACK_INFO',
};

String eventName(int id) => kEventNames[id] ?? 'EVT_$id';
