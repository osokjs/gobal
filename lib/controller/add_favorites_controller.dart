import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gobal/database/database_helper.dart';
import 'package:gobal/gps/gps_info.dart';
import 'package:gobal/model/favorite_data.dart';
import 'package:gobal/model/group_code.dart';


class AddFavoriteController extends GetxController {

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
  // int selectedCategoryId = 1; // 1: '일반'
  GroupCode selectedCategory = GroupCode(id: 0, name: '없음');

final TextEditingController nameController = TextEditingController(); // 현재 위치 이름(즐겨찾기)
  final TextEditingController groupController = TextEditingController(); // 등록할 카테고리 이름(그룹명)
  final TextEditingController editGroupController = TextEditingController(); // 변경할 카테고리 이름(그룹명)

  static AddFavoriteController get to => Get.find();


  @override
  void onInit() {
    log('AddFavoriteController: onInit starting...');
    getPosition();
    getAllGroupCode();
    super.onInit();
  } // onInit

  @override
  void onClose() {
    nameController.dispose();
    groupController.dispose();
    editGroupController.dispose();
    super.onClose();
  } // onClose


  void getPosition() async {
    try {
      position = await GpsInfo.instance.getMyCurrentPosition();
      update();
    } catch (e) {
      log('getPosition: ${e.toString()}');
    }
  } // getPosition

  void setEditModeValue(FavoriteData fd) {
    nameController.text = fd.name;
    selectedCategory = findGroupCodeById(fd.groupId);
    position = Position(
      latitude: fd.latitude,
      longitude: fd.longitude,
      accuracy: fd.accuracy,
      speed: 0.0,
      speedAccuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      timestamp: DateTime.now(),
    );
  } // setEditModeValue

  void getAllGroupCode() async {
    try {
      groupList = await DatabaseHelper.instance.queryAllGroupCode();
      groupList.insert(0, GroupCode(id: 0, name: '없음'));
      selectedCategory = groupList[0];
      update();
    } catch (e) {
      log('getAllGroupCode: ${e.toString()}');
    }
  } // getAllGroupCode

  void selectGroupCode(GroupCode value) {
    selectedCategory = value;
    update();
  } // selectGroupCode

  Future<int> addGroupCode(String name) async {
    int result = 0;
    try {
      result = await DatabaseHelper.instance.insertGroupCode(name);
      log('addGroupCode: result=$result');
    } catch (e) {
      result = -1;
      log('addGroupCode: ${e.toString()}');
      rethrow;
    }
    return result;
  } // addGroupCode

  void deleteGroupCode(int id) async {
    int result = 0;
    try {
      result = await DatabaseHelper.instance.deleteById('groupCode', id);
      log('delete GroupCode: result=$result');
    } catch (e) {
      log('delete GroupCode: ${e.toString()}');
    }
  } // deleteGroupCode

  void updateGroupCode(GroupCode data) async {
    int result = 0;
    try {
      result = await DatabaseHelper.instance.updateGroupCode(data);
      log('update GroupCode: result=$result');
    } catch (e) {
      log('update GroupCode: ${e.toString()}');
    }
  } // updateGroupCode

  GroupCode findGroupCodeById(int id) {
    for(GroupCode gc in groupList) {
      if(id == gc.id) return gc;
    }
    // 찾지 못한 경우
    return GroupCode(id: 0, name: '없음');
  } // findGroupCodeById

  void addFavoriteData(String name) async {
    int result = 0;

    try {
      result = await DatabaseHelper.instance.insertFavorite(
          FavoriteData(
            id: 0, // autoincrement field
            groupId: selectedCategory.id,
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

