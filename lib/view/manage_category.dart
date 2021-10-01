import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobal/controller/add_favorites_controller.dart';

class ManageCategory extends StatefulWidget {
  const ManageCategory({Key? key}) : super(key: key);

  @override
  _ManageCategoryState createState() => _ManageCategoryState();
}

class _ManageCategoryState extends State<ManageCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카테고리 관리'),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
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
                  const SizedBox(width: 10,),
                  ElevatedButton(
                    child: const Text('저장'),
                    onPressed: () {
                      String value = AddFavoriteController.to.groupController.text.trim();

                      log('text value($value)');
                      if(!_checkCategoryName(value)) return;
                      AddFavoriteController.to.addGroupCode(value);
                      AddFavoriteController.to.getAllGroupCode();

                      AddFavoriteController.to.groupController..clear();
                    },
                  ), // ElevatedButton
                ],
              ), // Row
              SizedBox(height: 10,),
              buildGroupList(context),
              SizedBox(height: 1,),
            ],
          ), // Column
        ), // GestureDetector
      ), // SafeArea
    );
  } // build

  Widget buildGroupList(BuildContext context) {
    return Expanded(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GetBuilder<AddFavoriteController>(
            builder: (_dx) => ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _dx.groupList.length,
              itemBuilder: (context, index) {
                return Text(
                  '${_dx.groupList[index].name}, idx = $index',
                );
              },
            ), // ListView.builder
          ), // GetBuilder
        ],
      ), // Column
    ); // Expanded
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


