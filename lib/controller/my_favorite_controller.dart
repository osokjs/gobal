import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gobal/database/database_helper.dart';
import 'package:gobal/gps/gps_info.dart';
import 'package:gobal/model/read_favorite_data.dart';
import 'package:gobal/model/favorite_info.dart.dart';
import 'package:gobal/model/group_code.dart';


class MyFavoriteController extends GetxController {

  static const _TIMER_DURATION = 5;
  static MyFavoriteController get to => Get.find();

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

  List<ReadFavoriteData> favoriteList = <ReadFavoriteData>[];
  List<FavoriteInfo> infoList = <FavoriteInfo>[]; // 화면에 표시할 데이터
  GroupCode selectedCategory = GroupCode(id: 1, name: '일반');

  Timer? _timer;
  // final TextEditingController nameController = TextEditingController(); // 현재 위치 이름(즐겨찾기)
  // final TextEditingController groupController = TextEditingController(); // 카테고리 이름, 그룹명


  @override
  void onInit() {
    getAllFavoriteData();
    initPosition();
    getPosition();
    _timer = Timer.periodic(Duration(seconds: _TIMER_DURATION), (timer)  {
      calculateDistanceAndBearing(timer);
    });
    super.onInit();
  } // onInit

  @override
  void onClose() {
    // nameController.dispose();
    // groupController.dispose();
    _timer?.cancel();
    super.onClose();
  } // onClose

  void calculateDistanceAndBearing(Timer timer) async {
    try {
      double distance, bearing;
      String strDistance, strBearing;

      position = await GpsInfo.instance.getMyCurrentPosition();
      infoList.clear();
      for(int i = 0; i < favoriteList.length; i++ ) {
        distance = _getDistance(position.latitude, position.longitude, favoriteList[i].latitude, favoriteList[i].longitude);
        strDistance = _distanceString(distance);
        bearing = _getBearing(position.latitude, position.longitude, favoriteList[i].latitude, favoriteList[i].longitude);
        strBearing = _bearingString(bearing);
        infoList.add(
          FavoriteInfo(
            id: favoriteList[i].id,
            name: favoriteList[i].name,
            distance: distance,
            category: favoriteList[i].groupName,
            info: _makeInfoMsg(favoriteList[i].name, strDistance, strBearing, favoriteList[i].groupName),
          ),
        );
      }
      infoList.sort((a, b) => a.distance.compareTo(b.distance));
      update();
    } catch (e) {
      log('timer(): ${DateTime.now().toString()}, ${e.toString()}');
    }
  } // calculateDistanceAndBearing

  void initPosition()  async {
    await GpsInfo.instance.determinePosition();
  } // initPosition

  void getPosition() async {
    try {
      position = await GpsInfo.instance.getMyCurrentPosition();
      update();
    } catch (e) {
      log('getPosition: ${e.toString()}');
    }
  } // getPosition

  double _getDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
      return GpsInfo.instance.getDistanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
      }

      String _distanceString(double distance) {
        String str = (distance <= 1000) ? '${distance.round()} M '
            :'${(distance/1000.0).round()} KM';
        return str.padLeft(8).substring(0, 8);
              }

  double _getBearing(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    return GpsInfo.instance.getBearingBetween(startLatitude, startLongitude, endLatitude, endLongitude);
  }

  String _bearingString(double bearing) {
    String str = '${bearing.round()}도';
    return str.padLeft(5).substring(0, 5);
  }

String _makeInfoMsg(String name, String strDistance, String strBearing, String category) {
    String strName = name.padRight(20).substring(0, 20);
  return '$strName $strDistance $strBearing $category';
  }


  void getAllFavoriteData() async {
    try {
      favoriteList = await DatabaseHelper.instance.queryAllFavorite();
      // selectedCategory = groupList[0];
      update();
    } catch (e) {
      log('getAllFavoriteData: ${e.toString()}');
    }
  } // getAllFavoriteData


  // void addFavoriteData(String name) async {
  //   int result = 0;
  //
  //   try {
  //     result = await DatabaseHelper.instance.insertFavorite(
  //         FavoriteData(
  //           id: 0, // autoincrement field
  //           groupId: selectedCategory.id,
  //           name: name,
  //           latitude: position.latitude,
  //           longitude: position.longitude,
  //           accuracy: position.accuracy,
  //           updated:DateTime.now().toString(),
  //         )
  //     );
  //     log('addFavorite: result=$result');
  //   } catch (e) {
  //     log('addFavorite: ${e.toString()}');
  //   }
  // } // addFavorite

  ReadFavoriteData? findReadFavoriteDataById(int id) {
    for(int i=0; i < favoriteList.length; i++) {
      if(favoriteList[i].id == id)
        return favoriteList[i];
    }
    return null;
  } // findReadFavoriteDataById



} // class

