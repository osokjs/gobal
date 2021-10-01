import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gobal/database/database_helper.dart';
import 'package:gobal/gps/gps_info.dart';
import 'package:gobal/model/favorite_data.dart';
import 'package:gobal/model/group_code.dart';


class AddFavoriteController extends GetxController {

  static AddFavoriteController get to => Get.find();

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

  List<GroupCode> groupList = <GroupCode>[];
  int selectedCategoryId = 1; // 1: '일반'

final TextEditingController nameController = TextEditingController(); // 현재 위치 이름(즐겨찾기)
  final TextEditingController groupController = TextEditingController(); // 카테고리 이름, 그룹명


  @override
  void onInit() {
    initPosition();
    getAllGroupCode();
    super.onInit();
  } // onInit

  @override
  void onClose() {
    nameController.dispose();
    groupController.dispose();
    super.onClose();
  } // onClose

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

  void getAllGroupCode() async {
    try {
      groupList = await DatabaseHelper.instance.queryAllGroupCode();
      selectedCategoryId = groupList[0].id;
      update();
    } catch (e) {
      log('getAllGroupCode: ${e.toString()}');
    }
  } // getAllGroupCode

  void selectGroupCode(int value) {
    selectedCategoryId = value;
    update();
  }

  void addGroupCode(String name) async {
    int result = 0;
    try {
      result = await DatabaseHelper.instance.insertGroupCode(name);
      log('addGroupCode: result=$result');
    } catch (e) {
      log('addGroupCode: ${e.toString()}');
    }
  } // addGroupCode


//   int findCategoryId() {
//     int id = -1;
//     for(int i=0; i < groupList.length; i++) {
//       if(groupList[i].name.compareTo(selectedCategory) == 0) return groupList[i].id;
// //log('i=$i, name=$selectedCategory, gc.name=${groupList[i].name}, id=$id');
//     }
//     return id;
//   }


  void addFavoriteData(String name) async {
    int result = 0;

    try {
      result = await DatabaseHelper.instance.insertFavorite(
          FavoriteData(
            id: 0, // autoincrement field
            groupId: selectedCategoryId,
            name: name,
            latitude: position.latitude,
            longitude: position.longitude,
            accuracy: position.accuracy,
            updated:DateTime.now().toString(),
          )
      );
      log('addFavorite: result=$result');
    } catch (e) {
      log('addFavorite: ${e.toString()}');
    }
  } // addFavorite


} // class

