import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobal/view/add_favorites.dart';

import 'package:gobal/view/my_homepage.dart';
import 'package:gobal/view/my_favorite.dart';
import 'package:gobal/view/my_config.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GO발',
      theme:ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
        getPages: [
        GetPage(name: '/', page: () => MyHomePage()),
    GetPage(name: '/favorite', page: () => MyFavorite()),
    GetPage(name: '/add_favorite', page: () => AddFavorite()),
    GetPage(name: '/config', page: () => MyConfig()),
      ],
    );
  }
} // MyApp

