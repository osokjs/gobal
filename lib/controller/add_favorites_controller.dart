import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gobal/database/database_helper.dart';
import 'package:gobal/gps/gps_info.dart';
import 'package:gobal/model/favorite_data.dart';
import 'package:gobal/model/group_code.dart';
import 'package:gobal/model/position_data.dart';
import 'package:gobal/model/read_favorite_data.dart';


class AddFavoriteController extends GetxController {

  static AddFavoriteController get to => Get.find();

  var position = PositionData().obs;
  var groupList = <GroupCode>[].obs;
  var selectedCategory = GroupCode(id: 0, name: '없음').obs;

final TextEditingController nameController = TextEditingController(); // 현재 위치 이름(즐겨찾기)
  final TextEditingController groupController = TextEditingController(); // 등록할 카테고리 이름(그룹명)
  final TextEditingController editGroupController = TextEditingController(); // 변경할 카테고리 이름(그룹명)

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
      Position pos = await GpsInfo.instance.getMyCurrentPosition();
      setPositionData(pos);
      // update();
    } catch (e) {
      log('getPosition: ${e.toString()}');
    }
  } // getPosition

  void setPositionData(Position pos) {
    position(PositionData(
        latitude: pos.latitude,
    longitude: pos.longitude,
    accuracy: pos.accuracy,
    ));
  } // setPositionData

  void setEditModeValue(ReadFavoriteData rfd) {
    nameController.text = rfd.name;
    // selectedCategory = findGroupCodeById(rfd.groupId);
    // selectedCategory = GroupCode(id: rfd.groupId, name: rfd.groupName);
    selectedCategory(GroupCode(id: rfd.groupId, name: rfd.groupName));
    position(PositionData(
      latitude: rfd.latitude,
      longitude: rfd.longitude,
      accuracy: rfd.accuracy,
    ));
  } // setEditModeValue

  void getAllGroupCode() async {
    try {
      groupList.clear();
      groupList.addAll(await DatabaseHelper.instance.queryAllGroupCode());
      groupList.insert(0, GroupCode(id: 0, name: '없음'));
      selectedCategory(groupList[0]);
      // update();
    } catch (e) {
      log('getAllGroupCode: ${e.toString()}');
    }
  } // getAllGroupCode

  void selectGroupCode(GroupCode value) {
    selectedCategory(value);
    // update();
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
            groupId: selectedCategory.value.id,
            name: name,
            latitude: position.value.latitude,
            longitude: position.value.longitude,
            accuracy: position.value.accuracy,
            updated:DateTime.now().toString(),
          )
      );
      log('addFavorite: result=$result');
    } catch (e) {
      log('addFavorite: ${e.toString()}');
    }
  } // addFavorite


} // class

