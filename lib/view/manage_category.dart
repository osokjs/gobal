import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobal/common/common.dart';
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
    log('ManageCategory initState starting');
    super.initState();
  }

  @override
  void dispose() {
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
      tooltip:'뒤로가기',
      icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Get.back(),
    ) , // IconButton
    actions:[
      IconButton(
        tooltip: '저장',
        icon: Icon(Icons.save, color: Colors.white),
        onPressed: () async {
          String value = AddFavoriteController.to.groupController.text.trim();

          log('group name($value)');
          if(!_checkCategoryName(value)) return;

          int result = await AddFavoriteController.to.addGroupCode(value);
          AddFavoriteController.to.getAllGroupCode();
          AddFavoriteController.to.groupController..clear();
          Common.unfocus(context);
          if(result > 0) Common.infoDialog(context, '카테고리가 등록되었습니다.');
        },
      ), // IconButton
    ],
    ), // AppBar
    body: Container(
    height: bodyHeight,
    width: maxWidth,
    padding: EdgeInsets.all(8.0),
    child: Column(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: AddFavoriteController.to.groupController,
            keyboardType: TextInputType.text,
            maxLength: 10,
            // autofocus: true,
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '카테고리 이름:',
              hintText: '카테고리 이름을 10자 이내로 입력하세요.',
            ),
          ), // TextFormField
        ), // Expanded
        SizedBox(height: 1,),
        _buildGroupList(context, bodyHeight, maxHeight),
        SizedBox(height: 1,),
      ],
    ), // Column
    ), // Container
    );  // Scaffold
  } // build

  Widget _buildGroupList(BuildContext context, double bodyHeight, double maxWidth) {
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
            if(index == 0) return Divider();
            else return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('${_dx.groupList[index].name}, id: ${_dx.groupList[index].id}',),
                IconButton(
                  tooltip:'수정',
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    Common.unfocus(context);
                    _updateGroupCodeDialog(context, _dx.groupList[index]);
                  },
                ) , // IconButton
                IconButton(
                  tooltip:'삭제',
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: () async {
                    log('delete GroupCode name: ${_dx.groupList[index].name}, id: ${_dx.groupList[index].id}');
                    bool answer = await Common.confirmDialog(context, '${_dx.groupList[index].name} 카테고리를 정말로 삭제 하시겠습니까?', title: '삭제 확인창', textConfirm: '삭제하기');
                    if(!answer) return;

                    Common.unfocus(context);
                    AddFavoriteController.to.deleteGroupCode(_dx.groupList[index].id);
                    AddFavoriteController.to.getAllGroupCode();
                  },
                ) , // IconButton
              ],
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
      Common.infoDialog(context, errorMessage);
      return false;
    } else if (value.length > 10) {
      errorMessage = '카테고리 이름은 최대 10자까지만 입력 가능합니다.';
      log(errorMessage);
      Common.infoDialog(context, errorMessage);
      return false;
    }
    return true;
  } // _checkCategoryName

  void _updateGroupCodeDialog(BuildContext context, GroupCode gc) async {
    AddFavoriteController.to.editGroupController.text = gc.name;
    log('-- ${gc.name}, id: ${gc.id}',);

    await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: Text('카테고리 수정창'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('${gc.name} 카테고리를 변경합니다.'),
              TextField(
                controller: AddFavoriteController.to.editGroupController,
                maxLength: 10,
                autofocus: true,
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '카테고리 이름:',
                  hintText: '변경할 카테고리 이름을 10자 이내로 입력하세요.',
                ),
              ),
            ],
          ), // Column
          actions: <Widget>[
            ElevatedButton(
              child: Text('수정하기'),
              onPressed: () {
                String value = AddFavoriteController.to.editGroupController.text.trim();

                log('update group name($value)');
                if(!_checkCategoryName(value)) return;

                AddFavoriteController.to.updateGroupCode(GroupCode(id: gc.id, name: value));
                AddFavoriteController.to.getAllGroupCode();
                Navigator.of(context).pop(true);
              },
            ), // ElevatedButton
              ElevatedButton(
                child: const Text('취소'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ), // ElevatedButton
          ],
        );
      },
    );
  } // _updateGroupCodeDialog


} // class ManageCategory

