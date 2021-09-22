import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gobal/database/database_helper.dart';
import 'package:gobal/gps/gps_info.dart';
import 'package:gobal/model/favorite_data.dart';


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

final TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    initPosition();
    super.onInit();
  } // onInit

  @override
  void onClose() {
    nameController.dispose();
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
      print(e);
    } finally {}
  } // getPosition

  void addFavorite(String name, int gId) async {
    int result = 0;
    try {
      result = await DatabaseHelper.instance.insertFavorite(
          FavoriteData(
            id: 0,
            gId: gId,
            name: name,
            latitude: position.latitude,
            longitude: position.longitude,
            accuracy: position.accuracy,
            updated:DateTime.now().toString(),
          )
      );
      assert(result == 1);
    } catch (e) {
      print(e);
    }
  } // addFavorite

} // class

