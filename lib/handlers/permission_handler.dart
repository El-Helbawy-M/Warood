import 'package:flutter_project_base/base/widgets/error_handler.dart';
import 'package:flutter_project_base/debug/log_printer.dart';
import 'package:flutter_project_base/utilities/components/custom_snack_bar.dart';
import 'package:permission_handler/permission_handler.dart';

import '../routers/navigator.dart';

class PermissionHandler {
  Future<bool> _checkPermissionIdGranted(Permission permission) async => permission.status.isGranted;
  Future<bool> _checkPermission(Permission permission) async {
    if (!(await _checkPermissionIdGranted(permission))) {
      if (await permission.status.isPermanentlyDenied) {
        log_check(label: "Permission Premenant check", currentValue: await _checkPermissionIdGranted(permission), expectedValue: false);
        ErrorHandler().showErrorDialog(
          title: "غير مسموح",
          message: "الرجاء السماح بالوصول لموقعك من خلال الاعدادات",
          context: CustomNavigator.navigatorState.currentContext!,
        );
        return false;
      } else {
        PermissionStatus status = await permission.request();
        bool value = status.isGranted;
        log_check(label: "Permission is Denied after request check", currentValue: value, expectedValue: true);
        if (!value) {
          ErrorHandler().showErrorDialog(
            title: "غير مسموح",
            message: "الرجاء السماح بالوصول لموقعك من خلال الاعدادات",
            context: CustomNavigator.navigatorState.currentContext!,
          );
        }
        return value;
      }
    } else {
      log_check(label: "Permission check", currentValue: await _checkPermissionIdGranted(permission), expectedValue: true);
      return true;
    }
  }

  Future<bool> checkCameraPermission() async => _checkPermission(Permission.camera);

  Future<bool> checkNotificationPermission() async => _checkPermission(Permission.notification);

  Future<bool> checkBluetoothPermission() async => _checkPermission(Permission.bluetoothConnect);

  Future<bool> checkContactsPermission() async => _checkPermission(Permission.contacts);

  Future<bool> checkLocationPermission() async => _checkPermission(Permission.location);
}
