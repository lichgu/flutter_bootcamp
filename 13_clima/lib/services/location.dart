import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitude;

  // see https://pub.dev/packages/geolocator for example including checking if
  // the location services are enabled and checking / requesting permission to
  // access the position of the device
  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
