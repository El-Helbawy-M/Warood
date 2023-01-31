import 'package:flutter_project_base/debug/log_printer.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<bool> _checkPermissionIdGranted(Permission permission) async => permission.status.isGranted;
  Future<bool> _checkPermission(Permission permission) async {
    if (await _checkPermissionIdGranted(permission)) {
      if (await permission.status.isPermanentlyDenied) {
        log_check(label: "Permission check", currentValue: _checkPermissionIdGranted(permission), expectedValue: false);
        // show message
        return false;
      } else {
        await permission.request();
        log_check(label: "Permission check", currentValue: _checkPermissionIdGranted(permission), expectedValue: true);
        return await _checkPermissionIdGranted(permission);
      }
    } else {
      log_check(label: "Permission check", currentValue: _checkPermissionIdGranted(permission), expectedValue: true);
      return true;
    }
  }

  Future<bool> checkCameraPermission() async => _checkPermission(Permission.camera);

  Future<bool> checkBluetoothPermission() async => _checkPermission(Permission.bluetoothConnect);

  Future<bool> checkContactsPermission() async => _checkPermission(Permission.contacts);
}