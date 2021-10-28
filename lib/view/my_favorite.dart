import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobal/controller/favorite_controller.dart';
import 'package:gobal/model/read_favorite_data.dart';

class MyFavorite extends StatefulWidget {
  const MyFavorite({Key? key}) : super(key: key);

  @override
  _MyFavoriteState createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {

  final FavoriteController myFavoriteController =
  Get.put(FavoriteController());


  @override
Widget build(BuildContext context) {
  final mq = MediaQuery.of(context);
  final maxHeight = mq.size.height;
  final maxWidth = mq.size.width;
  final appBarHeight = AppBar().preferredSize.height;
  final padding = mq.padding.top + mq.padding.bottom;
  final insets = mq.viewInsets.top + mq.viewInsets.bottom;
  final bodyHeight = maxHeight - appBarHeight - padding - insets;

  // final displaySize = mq.size;
  // final aspectRatio = displaySize.aspectRatio;
  // final devicePixelRatio = mq.devicePixelRatio;
  // final textScaleFactor = mq.textScaleFactor;
  // final orientation = mq.orientation;

  return Scaffold(
    appBar: AppBar(
      title: const Text('즐겨찾기'),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        tooltip: '뒤로가기',
        icon: Icon(Icons.arrow_back, color: Colors.white),
      ), // IconButton
      actions: [
        Obx(() => IconButton(
                tooltip: (FavoriteController.to.isEditMode.value) ? '편집 종료' : '편집',
                icon: (FavoriteController.to.isEditMode.value) ? Icon(Icons.edit_off_outlined, color: Colors.yellow)
                    : Icon(Icons.edit_location_alt, color: Colors.white),
                onPressed: () {
                  FavoriteController.to.changeEditMode();
                },
              ), // IconButton
        ), // Obx
      ],
    ), // AppBar

    body: Container(
      height: bodyHeight,
      width: maxWidth,
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: bodyHeight * 0.2,
            child: Obx(() => Text(
                'GPS 정확도: ${FavoriteController.to.position.value.accuracy.round()} M'),
            ), // Obx
          ), // Container

          Expanded(
            // flex: 4,
                  child: Obx(() {
                      log('builder length: ${FavoriteController.to.favoriteList.length}');
                      if (FavoriteController.to.favoriteList.length < 1) {
                        return Text('등록된 즐겨찾기가 없습니다.');
                      } else {
                        log('length: ${FavoriteController.to.favoriteList.length}, ${FavoriteController.to.infoList.length}');
                        return ListView.builder(
                          itemCount: FavoriteController.to.favoriteList.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(FavoriteController.to.infoList[index].info),
                                _editModeWidget(FavoriteController.to.favoriteList[index]),
                              ],
                            );
                          },
                        ); // ListView.builder
                      } // else
                    },
                  ), // Obx
          ), // Expanded
        ],
      ), // Column
    ), // Container
  ); // Scaffold
} // build

  Widget _editModeWidget(ReadFavoriteData rfd) {
    if (!FavoriteController.to.isEditMode.value) {
      return SizedBox.shrink();
    } else {
      return Row(
        children: <Widget>[
          IconButton(
            tooltip: '수정',
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              Get.toNamed('/add_favorite',
                arguments: rfd,);
            },
          ), // IconButton
          IconButton(
            tooltip: '삭제',
            icon: Icon(Icons.delete, color: Colors.purple),
            onPressed: () {
              FavoriteController.to.deleteFavoriteData(rfd.id);
              FavoriteController.to.getAllFavoriteData();
            },
          ), // IconButton
        ],
      ); // Row
    } // else
  } // _editModeWidget



} // class
