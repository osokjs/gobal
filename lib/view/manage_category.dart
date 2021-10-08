import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobal/controller/add_favorites_controller.dart';
import 'package:gobal/model/group_code.dart';

class ManageCategory extends StatefulWidget {
  const ManageCategory({Key? key}) : super(key: key);

  @override
  _ManageCategoryState createState() => _ManageCategoryState();
}

class _ManageCategoryState extends State<ManageCategory> {

  @override
  void initState() {
    super.initState();
    AddFavoriteController.to.groupList.removeAt(0);
  }

  @override
  void dispose() {
    AddFavoriteController.to.groupList.insert(0, GroupCode(id: 0, name: '없음'));
    super.dispose();
  }

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
        title: const Text('카테고리 관리'),
    centerTitle: true,
    leading: IconButton(
    onPressed: () => Navigator.of(context).pop(),
    tooltip:'뒤로가기',
    icon: Icon(Icons.arrow_back, color: Colors.purple),
    autofocus: true,
    ) , // IconButton
    actions:[
    ElevatedButton(
    child: const Text('저장'),
    onPressed: () {
    String value = AddFavoriteController.to.groupController.text.trim();

    log('group name($value)');
    if(!_checkCategoryName(value)) return;
    AddFavoriteController.to.addGroupCode(value);
    AddFavoriteController.to.getAllGroupCode();

    AddFavoriteController.to.groupController..clear();
    },
    ), // ElevatedButton
    ],
    ), // AppBar
    body: Container(
    height: bodyHeight,
    width: maxWidth,
    padding: EdgeInsets.all(8.0),
    child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Column(
          children: <Widget>[
            Container(
              height: bodyHeight * 0.3,
                              width: maxWidth,
                              padding: EdgeInsets.all(8.0),
                              child: Expanded(
                                child: TextField(
                                  controller: AddFavoriteController.to.groupController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: '카테고리 이름:',
                                    hintText: '카테고리 이름을 10자 이내로 입력하세요.',
                                  ),
                                ), // TextFormField
                              ), // Expanded
            ), // Container
            buildGroupList(context, bodyHeight, maxHeight),
            // SizedBox(height: 1,),
          ],
        ), // Container
      ), // GestureDetector
    ), // Container
    );  // Scaffold
  } // build

  Widget buildGroupList(BuildContext context, double bodyHeight, double maxWidth) {
    return Expanded(
    // return Container(
    //   height: bodyHeight * 0.7,
    //   width:maxWidth,
    //   padding: EdgeInsets.all(8.0),
      child: GetBuilder<AddFavoriteController>(
        builder: (_dx) => ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _dx.groupList.length,
          itemBuilder: (context, index) {
            return Text(
              '${_dx.groupList[index].name}, id: ${_dx.groupList[index].id}',
            );
          },
        ), // ListView.builder
      ), // GetBuilder
    ); // Container
  } // buildGroupList

  bool _checkCategoryName(String value) {
    String errorMessage = '정상';

    if (value.length < 1) {
      errorMessage = '카테고리 이름은 반드시 입력해야 합니다.';
      log(errorMessage);
      // _showAlertDialog(context, errorMessage);
      return false;
    } else if (value.length > 10) {
      errorMessage = '카테고리 이름은 최대 10자까지만 입력 가능합니다.';
      log(errorMessage);
      // _showAlertDialog(context, errorMessage);
      return false;
    }
    return true;
  } // _checkCategoryName


} // class ManageCategory


