import 'package:permission_handler/permission_handler.dart';

/// Checks permissions and returns true if all granted, false otherwise.
Future<bool> checkRequiredPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.locationWhenInUse,
    Permission.storage,
    Permission.notification,
  ].request();

  return statuses.values.every((status) => status.isGranted);
}
