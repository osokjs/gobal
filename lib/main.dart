import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobal/view/add_favorites.dart';
import 'package:gobal/view/manage_category.dart';

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
          // primaryColorLight: Colors.pink[300],
          // backgroundColor: Colors.orange[300],
          // dialogBackgroundColor: Colors.green[300],
          // scaffoldBackgroundColor: Colors.purple[300],
          // cardColor: Colors.yellow[300],
          // accentColor: Colors.amberAccent,
          // brightness: Brightness.light,
        // iconTheme: IconThemeData(opacity: , size: , color: ,),
        // dialogTheme: DialogTheme(backgroundColor: , elevation: , titleTextStyle: , contentTextStyle: ,),
        // textButtonTheme: TextButtonThemeData(),
        // elevatedButtonTheme: ElevatedButtonThemeData(),
          // outlinedButtonTheme: OutlinedButtonThemeData(),
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic), //dialog title
            subtitle1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), //dialog content
          bodyText2: TextStyle(fontSize: 14.0, ),
        ), // TextTheme
      ), // ThemeData
      initialRoute: '/',
        getPages: [
        GetPage(name: '/', page: () => MyHomePage()),
    GetPage(name: '/favorite', page: () => MyFavorite()),
    GetPage(name: '/add_favorite', page: () => AddFavorite()),
    GetPage(name: '/add_favorite/manage_category', page: () => ManageCategory()),
    GetPage(name: '/config', page: () => MyConfig()),
      ],
    );
  }
} // MyApp

