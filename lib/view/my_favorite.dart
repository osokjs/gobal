import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobal/controller/my_favorite_controller.dart';

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
          autofocus: true,
        ), // IconButton
        actions: [
        ElevatedButton(
          child: const Text('편집'),
          onPressed: () {},
        ), // ElevatedButton
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
                  return Text('GPS 정확도: ${_ctrl.position.accuracy.round()}');
                },
              ), // GetBuilder
            ), // Container

            Expanded(
              // flex: 4,
              child: GetBuilder<MyFavoriteController>(
                builder: (_ctrl) {
                  // log('GetBuildr: builder, length: ${_ctrl.favoriteList.length}');
                  if (_ctrl.favoriteList.length < 1) {
                    return Text('등록된 데이터가 없습니다.');
                  } else {
                    return ListView.builder(
                      itemCount: _ctrl.favoriteList.length,
                      itemBuilder: (context, index) {
                        return Text(_ctrl.infoList[index].info);
                      },
                    ); // ListView.builder
                  } // else
                },
              ), // GetBuilder
            ), // Expanded
          ],
        ), // Column
      ), // Container
    );
  }
}
