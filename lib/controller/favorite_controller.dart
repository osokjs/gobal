import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gobal/common/common.dart';
import 'package:gobal/database/database_helper.dart';
import 'package:gobal/gps/gps_info.dart';
import 'package:gobal/model/position_data.dart';
import 'package:gobal/model/read_favorite_data.dart';
import 'package:gobal/model/favorite_info.dart.dart';
import 'package:gobal/model/group_code.dart';


class FavoriteController extends GetxController {

  static const _TIMER_DURATION = 5;
  static FavoriteController get to => Get.find();

  var position = PositionData().obs;

  var favoriteList = <ReadFavoriteData>[].obs;
  var infoList = <FavoriteInfo>[].obs; // 화면에 표시할 데이터
  var selectedCategory = GroupCode(id: 0, name: '없음').obs;

  Timer? _timer;
  var isEditMode = false.obs; // true: 위치 수정, false: 위치 추가
bool _isFirstExecute = true; // 최초 실행시

  @override
  void onInit() {
    getAllFavoriteData();
    // getPosition();
    myTimer(ActionKind.start);
    super.onInit();
  } // onInit

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  } // onClose

  void changeEditMode() {
    isEditMode.value = !isEditMode.value;
    log('changeEditMode: editMode = ${isEditMode.value}');
    (isEditMode.value) ? myTimer(ActionKind.finish) : myTimer(ActionKind.start);
    // update();
  } // changeEditMode

  void myTimer(ActionKind kind) {
    if(kind == ActionKind.start) {
      _timer = Timer.periodic(Duration(seconds: _TIMER_DURATION), (timer) {
        calculateDistanceAndBearing();
      });
    } else {
      _timer?.cancel();
    }
      } // myTimer

  Future<List<FavoriteInfo>> calculateDistanceAndBearing() async {

    if (_isFirstExecute == true) {
      _isFirstExecute = false;
      await Future.delayed(Duration(milliseconds: 10,), () {
            log('최초 한 번만 100밀리초 대기합니다.');
          } );
    }

    try {
      double distance, bearing;
      String strDistance, strBearing;
      String strInfo;

      Position pos = await GpsInfo.instance.getMyCurrentPosition();
      log('정확도: ${pos.accuracy}, 위도: ${pos.latitude}, 경도: ${pos.longitude}, time: ${pos.timestamp?.toLocal().toString()}');
      position(PositionData(
        latitude: pos.latitude,
        longitude: pos.longitude,
        accuracy: pos.accuracy,
      ));
      infoList.clear();
      for(int i = 0; i < favoriteList.length; i++ ) {
        distance = _getDistance(position.value.latitude, position.value.longitude, favoriteList[i].latitude, favoriteList[i].longitude);
        strDistance = _distanceString(distance);
        bearing = _getBearing(position.value.latitude, position.value.longitude, favoriteList[i].latitude, favoriteList[i].longitude);
        strBearing = _bearingString(bearing);
        strInfo = _makeInfoMsg(favoriteList[i].name, strDistance, strBearing, favoriteList[i].groupName);
        // log('strInfo: $strInfo');
        infoList.add(
          FavoriteInfo(
            id: favoriteList[i].id,
            name: favoriteList[i].name,
            distance: distance,
            category: favoriteList[i].groupName,
            info: strInfo,
          ),
        );
      }
      infoList.sort((a, b) => a.distance.compareTo(b.distance));
      update();
      return infoList;
    } catch (e) {
      log('_calculate: ${e.toString()}');
      return Future.error('calculateDistanceAndBearing: $e');
    }
  } // calculateDistanceAndBearing

  // void getPosition() async {
  //   try {
  //     position = await GpsInfo.instance.getMyCurrentPosition();
  //     update();
  //   } catch (e) {
  //     log('getPosition: ${e.toString()}');
  //   }
  // } // getPosition

  double _getDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
      return GpsInfo.instance.getDistanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
      }

      String _distanceString(double distance) {
        String str = (distance <= 1000) ? '${distance.round()} m '
            :'${(distance/1000.0).round()} km';
        return str.padLeft(8).substring(0, 8);
              }

  double _getBearing(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    return GpsInfo.instance.getBearingBetween(startLatitude, startLongitude, endLatitude, endLongitude);
  }

  String _bearingString(double bearing) {
    String str = '${bearing.round()} 도';
    return str.padLeft(7).substring(0, 7);
  }

String _makeInfoMsg(String name, String strDistance, String strBearing, String category) {
    String strName = name.padRight(20).substring(0, 20);
  return '$strName $strDistance $strBearing $category';
  }


  void getAllFavoriteData() async {
    try {
      favoriteList.clear();
      favoriteList.addAll(await DatabaseHelper.instance.queryAllFavorite());
      // for(var item in favoriteList) log('favorite: ${item.toString()}');
      // selectedCategory = groupList[0];
      // update();
    } catch (e) {
      log('getAllFavoriteData: ${e.toString()}');
    }
  } // getAllFavoriteData


  void deleteFavoriteData(int id) async {
    int result = 0;

    try {
      result = await DatabaseHelper.instance.deleteById(
          DatabaseHelper.favoritesTable, id);
      log('deleteFavorite: result = $result, id = $id');
    } catch (e) {
      log('deleteFavorite: ${e.toString()}');
    }
  } // deleteFavorite

  ReadFavoriteData? findReadFavoriteDataById(int id) {
    for(int i=0; i < favoriteList.length; i++) {
      if(favoriteList[i].id == id)
        return favoriteList[i];
    }
    return null;
  } // findReadFavoriteDataById



} // class

