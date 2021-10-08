import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gobal/database/database_helper.dart';
import 'package:gobal/gps/gps_info.dart';
import 'package:gobal/model/group_code.dart';


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

  // Timer? _timer;
  static HomePageController get  to =>Get.find();

  @override
  void onInit() {
    initPosition();
    // _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
            // try {
            //   position = await GpsInfo.instance.getMyCurrentPosition();
            //   update();
            // } catch (e) {
            //   log('timer(): ${DateTime.now().toString()}, ${e.toString()}');
            // }
    // });
    initGroupCodeTable(); // 이 앱에서는 카테고리와 GroupCode 라는 용어가 혼용되고 있음
    super.onInit();
  } // onInit

  @override
  void onClose() {
    // _timer?.cancel();
    super.onClose();
  } // onClose

  void initPosition()  async {
    try {
      position = await GpsInfo.instance.determinePosition();
      update();
    } catch (e) {
      log('initPosition: ${e.toString()}');
    }
  } // initPosition

  void getPosition() async {
    try {
      position = await GpsInfo.instance.getMyCurrentPosition();
      update();
    }
    catch (e) {
      log('getPosition: ${e.toString()}');
    }
  } // getPosition

void initGroupCodeTable() async {
try {
  List<GroupCode> list = await DatabaseHelper.instance.queryAllGroupCode();
  if(list.isEmpty) {
    // App 최초 한번만 수행한다.
    log('default group code inserting...');
    await DatabaseHelper.instance.insertGroupCode('일반');
    await DatabaseHelper.instance.insertGroupCode('집');
    await DatabaseHelper.instance.insertGroupCode('직장');
    await DatabaseHelper.instance.insertGroupCode('산책');
    log('-- default data inserted into groupCode table successfully.');
  }
} catch (e) {
  log('initGroupCode: ${e.toString()}');
}
}

} // class HomePageController

