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
        return Text('GPS 정확도: ${_.position.accuracy}');
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
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder( //모서리를 둥글게
                  borderRadius: BorderRadius.circular(20)),
              primary: Colors.blue,
              onPrimary: Colors.white, //글자색
              alignment: Alignment.centerLeft,
              textStyle: const TextStyle(fontSize: 30),
            ),
          ), // ElevatedButton
          ElevatedButton(
            child: Text('위치 추가'),
            onPressed: () => Get.toNamed('/add_favorite'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder( //모서리를 둥글게
                  borderRadius: BorderRadius.circular(20)),
              primary: Colors.blue,
              onPrimary: Colors.white, //글자색
              alignment: Alignment.centerLeft,
              textStyle: const TextStyle(fontSize: 30),
            ),
          ), // ElevatedButton
          ElevatedButton(
            child: Text('환경설정'),
            onPressed: () => Get.toNamed('/config'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder( //모서리를 둥글게
                  borderRadius: BorderRadius.circular(20)),
              primary: Colors.blue,
              onPrimary: Colors.white, //글자색
              alignment: Alignment.centerLeft,
              textStyle: const TextStyle(fontSize: 30),
            ),
          ), // ElevatedButton
        ],
      ), // Column
    );
  } // _buildBottom

} // MyHomePage
