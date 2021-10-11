import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobal/controller/my_homepage_controller.dart';

class MyHomePage extends StatelessWidget {
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
        title: Text('Home'),
      ),
      body: Container(
        height: bodyHeight,
        width: maxWidth,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
          _buildTop(bodyHeight * 0.3, maxWidth),
        _buildMiddle(bodyHeight * 0.13, maxWidth),
        _buildBottom(bodyHeight * 0.45, maxWidth),
            SizedBox(height: 1,),
          ],
        ),
      ),
    );
  } // build


Widget _buildTop(double height, double width) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      child: SizedBox(
      height: height * 0.7,
      child: Image.asset(
          'image/dog_2.jpg',
        semanticLabel: '안내견 사진',
        excludeFromSemantics: true,
    ), // Image.asset
    ), // SizedBox
    );  // Container
} // _buildTop

  Widget _buildMiddle(double height, double width) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      child: GetBuilder<HomePageController>(
        init: HomePageController(),
      builder: (_) {
        return Text('GPS 정확도: ${_.position.accuracy.round()} M');
      },
      ), // GetBuilder
    ); // Container
  } // _buildMiddle

  Widget _buildBottom(double height, double width) {
    // return Container(
    //   alignment: Alignment.center,
    //   height: height,
    //   width: width,
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ElevatedButton(
            child: Text('즐겨찾기'),
            onPressed: () => Get.toNamed('/favorite'),
          ), // ElevatedButton
          ElevatedButton(
            child: Text('위치 추가'),
            onPressed: () => Get.toNamed('/add_favorite'),
          ), // ElevatedButton
          ElevatedButton(
            child: Text('환경설정'),
            onPressed: () => Get.toNamed('/config'),
          ), // ElevatedButton
        ],
      ), // Column
    );
  } // _buildBottom

} // MyHomePage
