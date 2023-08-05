import 'package:geolocator/geolocator.dart';

import '../widgets/toasts.dart';

class LocationUtil {
  static Future<Position?> determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showErrorToast('Location permissions are denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showErrorToast(
          'Location permissions are permanently denied, we cannot request permissions.');
      return null;
    }
    try {
      final pos = await Geolocator.getCurrentPosition();
      return pos;
    } catch (e) {
      return null;
    }
  }
}
