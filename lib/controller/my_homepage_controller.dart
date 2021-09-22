import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gobal/gps/gps_info.dart';


class HomePageController extends GetxController {
  Position position = Position(
    latitude: 0.0,
    longitude: 0.0,
    accuracy: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
    altitude: 0.0,
    heading: 0.0,
    timestamp: DateTime.now(),
  );

  Timer? _timer;
  static HomePageController get  to =>Get.find();

  @override
  void onInit() {
    initPosition();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
            try {
              position = await GpsInfo.instance.getMyCurrentPosition();
              update();
            } catch (e) {
              print('timer(): ${DateTime.now().toString()}, $e');
            }
    });
    super.onInit();
  } // onInit

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  } // onClose

  void initPosition()  async {
    try {
      position = await GpsInfo.instance.determinePosition();
      update();
    } catch (e) {
      print('initPosition: $e');
    }
  } // initPosition

  void getPosition() async {
    try {
      position = await GpsInfo.instance.getMyCurrentPosition();
      update();
    }
    catch (e) {
      print(e);
    }
  } // getPosition

} // class HomePageController

