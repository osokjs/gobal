import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobal/controller/my_favorite_controller.dart';
import 'package:gobal/model/favorite_data.dart';
import 'package:gobal/model/read_favorite_data.dart';

class MyFavorite extends StatefulWidget {
  const MyFavorite({Key? key}) : super(key: key);

  @override
  _MyFavoriteState createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {
  final MyFavoriteController myFavoriteController =
      Get.put(MyFavoriteController());

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
    GetBuilder<MyFavoriteController>(
    builder: (_ctrl) {
              return IconButton(
                tooltip: (MyFavoriteController.to.isEditMode) ? '편집 종료' : '편집',
                icon: (MyFavoriteController.to.isEditMode) ? Icon(Icons.edit_off_outlined, color: Colors.yellow)
                    : Icon(Icons.edit_location_alt, color: Colors.white),
                onPressed: () {
                  MyFavoriteController.to.changeEditMode();
                },
              ); // IconButton
            }
          ), // GetBuilder
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
              child: GetBuilder<MyFavoriteController>(
                builder: (_ctrl) {
                  return Text('GPS 정확도: ${_ctrl.position.accuracy.round()} M');
                },
              ), // GetBuilder
            ), // Container

            Expanded(
              // flex: 4,
              child: GetBuilder<MyFavoriteController>(
                builder: (_ctrl) {
                  log('GetBuildr: builder, length: ${_ctrl.favoriteList.length}');
                  if (_ctrl.favoriteList.length < 1) {
                    return Text('등록된 즐겨찾기가 없습니다.');
                  } else {
                    return ListView.builder(
                      itemCount: _ctrl.favoriteList.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(_ctrl.infoList[index].info),
                            _editModeWidget(_ctrl.favoriteList[index]),
                          ],
                        );
                      },
                    ); // ListView.builder
                  } // else
                },
              ), // GetBuilder
            ), // Expanded
          ],
        ), // Column
      ), // Container
    ); // Scaffold
  } // build


  Widget _editModeWidget(ReadFavoriteData rfd) {
    if (!MyFavoriteController.to.isEditMode) {
return SizedBox.shrink();
    } else {
      return Row(
        children: <Widget>[
        IconButton(
          tooltip: '수정',
          icon: Icon(Icons.edit, color: Colors.black),
          onPressed: () {
            Get.toNamed('/add_favorite',
                arguments: FavoriteData(
                  id: rfd.id,
                  groupId: rfd.groupId,
                  name: rfd.name,
                  latitude: rfd.latitude,
                  longitude: rfd.longitude,
                  accuracy: rfd.accuracy,
                  updated: rfd.updated,
            ));
          },
        ), // IconButton
    IconButton(
    tooltip: '삭제',
    icon: Icon(Icons.delete, color: Colors.purple),
    onPressed: () {
      MyFavoriteController.to.deleteFavoriteData(rfd.id);
      MyFavoriteController.to.getAllFavoriteData();
    },
    ), // IconButton
    ],
      ); // Row
  } // else
  } // _editModeWidget


} // class
