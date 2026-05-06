/// Harvard / WHOOP 4.0 GATT UUIDs.
class WhoopsieUuids {
  static const String service = '61080001-8d6d-82b8-614a-1c8cb0f8dcc6';
  static const String cmdToStrap = '61080002-8d6d-82b8-614a-1c8cb0f8dcc6';
  static const String cmdFromStrap = '61080003-8d6d-82b8-614a-1c8cb0f8dcc6';
  static const String eventFromStrap = '61080004-8d6d-82b8-614a-1c8cb0f8dcc6';
  static const String dataFromStrap = '61080005-8d6d-82b8-614a-1c8cb0f8dcc6';
  static const String memfault = '61080007-8d6d-82b8-614a-1c8cb0f8dcc6';

  /// Short-suffix match used by some BLE libs that lowercase + trim.
  static bool isWhoopService(String uuid) =>
      uuid.toLowerCase().contains('61080001');
}
