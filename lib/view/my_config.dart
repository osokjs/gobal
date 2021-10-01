import 'package:flutter/material.dart';
import 'package:gobal/database/database_helper.dart';

class MyConfig extends StatefulWidget {
  const MyConfig({Key? key}) : super(key: key);

  @override
  _MyConfigState createState() => _MyConfigState();
}

class _MyConfigState extends State<MyConfig> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('환경설정'),
      ),
      body: Column(
        children: [
          ElevatedButton(
          child:Text('데이터베이스 제거'),
    onPressed: () {
          DatabaseHelper.instance.myDeleteDatabase();
    },
    ),
        ],
      ), // Column
    );
  }
}
