import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobal/controller/my_homepage_controller.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
          _buildTop(),
        _buildMiddle(),
        _buildBottom(),
          ],
        ),
      ),
    );
  } // build


Widget _buildTop() {
    return Center(
      child: SizedBox(
      width: 280,
      child: Image.asset(
          'image/dog_2.jpg',
        semanticLabel: '안내견 사진',
        excludeFromSemantics: true,
    ),
    ),
    );
} // _buildTop

  Widget _buildMiddle() {
    return Center(
      child: GetBuilder<HomePageController>(
        init: HomePageController(),
      builder: (_) {
        return Text('GPS 정확도: ${_.position.accuracy.round()}');
      },
      ),
    );
  } // _buildMiddle

  Widget _buildBottom() {
    return Center(
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
