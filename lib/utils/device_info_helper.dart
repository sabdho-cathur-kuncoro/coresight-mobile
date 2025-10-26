import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoHelper {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  /// Get a map of useful device details (for both Android & iOS)
  static Future<Map<String, String>> getDeviceDetails() async {
    try {
      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        return {
          'device_id': info.id,
          'device_model': info.model,
          'device_brand': info.brand,
          'os_version': 'Android ${info.version.release}',
        };
      } else if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        return {
          'device_id': info.identifierForVendor ?? '',
          'device_model': info.utsname.machine,
          'device_brand': 'Apple',
          'os_version': '${info.systemName} ${info.systemVersion}',
        };
      }
    } catch (e) {
      print("Device info error: $e");
    }
    return {
      'device_id': '',
      'device_model': '',
      'device_brand': '',
      'os_version': '',
    };
  }
}
