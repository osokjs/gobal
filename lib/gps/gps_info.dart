import 'dart:developer';

import 'package:geolocator/geolocator.dart';

class GpsInfo {
  // singleton
  GpsInfo._privateConstructor();
  static final GpsInfo instance = GpsInfo._privateConstructor();

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
// Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
// Location services are not enabled don't continue
// accessing the position and request users of the
// App to enable the location services.
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
// Permissions are denied, next time you could try
// requesting permissions again (this is also where
// Android's shouldShowRequestPermissionRationale
// returned true. According to Android guidelines
// your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
// Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
// When we reach here, permissions are granted and we can
// continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
      timeLimit: Duration(seconds: 10),
    );
  } // determinePosition

  Future<Position> getMyCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            timeLimit: Duration(seconds: 10),
          );
    } catch (e) {
      log('getMyCurrentPosition: ${e.toString()}');
      return Future.error('getCurrentPosition에서 에러 발생: ${e.toString()}');
    }

  } // getMyCurrentPosition

  double getDistanceBetween(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
  }

  double getBearingBetween(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    return Geolocator.bearingBetween(startLatitude, startLongitude, endLatitude, endLongitude);
  }


} // class GpsInfo

