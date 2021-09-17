import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
      child: Image.asset('image/dog_2.jpg'),
    ),
    );
} // _buildTop

  Widget _buildMiddle() {
    return Center(
      child: Text('display accuracy'),
    );
  } // _buildMiddle

  Widget _buildBottom() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ElevatedButton(
            onPressed: () => Get.toNamed('/favorite'),
            child: Text('즐겨찾기',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder( //모서리를 둥글게
                  borderRadius: BorderRadius.circular(20)),
              primary: Colors.blue,
              onPrimary: Colors.white, //글자색
              //minimumSize: Size(200, 100), //width, height
              //child 정렬 - 아래의 Text('$test')
              alignment: Alignment.centerLeft,
              textStyle: const TextStyle(fontSize: 30),
            ),
          ), // ElevatedButton
          ElevatedButton(
            onPressed: () => Get.toNamed('/current_position'),
            child: Text('현재위치',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder( //모서리를 둥글게
                  borderRadius: BorderRadius.circular(20)),
              primary: Colors.blue,
              onPrimary: Colors.white, //글자색
              //minimumSize: Size(200, 100), //width, height
              //child 정렬 - 아래의 Text('$test')
              alignment: Alignment.centerLeft,
              textStyle: const TextStyle(fontSize: 30),
            ),
          ), // ElevatedButton
          ElevatedButton(
            onPressed: () => Get.toNamed('/common'),
            child: Text('환경설정',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder( //모서리를 둥글게
                  borderRadius: BorderRadius.circular(20)),
              primary: Colors.blue,
              onPrimary: Colors.white, //글자색
              //minimumSize: Size(200, 100), //width, height
              //child 정렬 - 아래의 Text('$test')
              alignment: Alignment.centerLeft,
              textStyle: const TextStyle(fontSize: 30),
            ),
          ), // ElevatedButton
        ],
      ), // Column
    );
  } // _buildBottom

} // MyHomePageState
