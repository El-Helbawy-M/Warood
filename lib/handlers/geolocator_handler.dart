import 'package:flutter_project_base/handlers/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorHandler {
  Future<Position?> getLocation() async {
    if (await PermissionHandler().checkLocationPermission()) {
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    } else {
      throw Exception("No Location");
    }
  }
}
