import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobal/common/common.dart';
import 'package:gobal/controller/add_favorites_controller.dart';
import 'package:gobal/model/group_code.dart';
import 'package:gobal/model/read_favorite_data.dart';

class AddFavorite extends StatefulWidget {
  const AddFavorite({Key? key}) : super(key: key);

  @override
  _AddFavoriteState createState() => _AddFavoriteState();
}

class _AddFavoriteState extends State<AddFavorite> {
  final AddFavoriteController _addFavoriteController =
      Get.put(AddFavoriteController());

  ReadFavoriteData? _readFavoriteData;
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _readFavoriteData = (Get.arguments == null) ? null : Get.arguments as ReadFavoriteData;
    if(_readFavoriteData != null) {
      _isEditMode = true;
      AddFavoriteController.to.setEditModeValue(_readFavoriteData!);  // !는 null이 아님을 보장한다는 뜻임
    }
      log('-- initState starting...editMode=$_isEditMode, $_readFavoriteData');
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

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
        title: (_isEditMode) ? const Text('위치 수정') : const Text('위치 추가'),
        centerTitle: true,
        leading: IconButton(
          tooltip: '뒤로가기',
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ), // IconButton
        actions: [
          IconButton(
            tooltip: '저장',
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: () {
              String value = _addFavoriteController.nameController.text.trim();
              if (!_checkFavoriteName(value)) return;
              _addFavoriteController.addFavoriteData(value);
              Get.back();
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
            Container(
              // 원래 윗 부분
              height: bodyHeight * 0.5,
              width: maxWidth,
              padding: EdgeInsets.all(8.0),
              //       Expanded( // 원래 윗 부분
              //         flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _addFavoriteController.nameController,
                      keyboardType: TextInputType.text,
                      maxLength: 20,
                      autofocus: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '위치 이름:',
                        hintText: '위치 이름을 20자 이내로 입력하세요.',
                      ),
                    ), // TextField
                  ), // Expanded

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('카테고리:'),
                      Obx(() => Expanded(
                          child: DropdownButton<GroupCode>(
                            isExpanded: true,
                            // hint: Text('${_ctrl.selectedCategory.name}: 카테고리를 선택하세요.'),
                            enableFeedback: true,
                            value: _addFavoriteController.selectedCategory.value,
                            items: _addFavoriteController.groupList.map(
                              (data) {
                                return DropdownMenuItem(
                                  value: data,
                                  child: Text(data.name),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              _addFavoriteController.selectGroupCode(val ?? _addFavoriteController.groupList[0]); // 0: '없음'
                              Common.unfocus(context);
                            },
                          ), // DropDownButton
                        ), // Expanded
                        ), // Obx
                      IconButton(
                        tooltip: '카테고리 관리',
                        icon: Icon(Icons.category, color: Colors.white),
                        onPressed: () => Get.toNamed('/add_favorite/manage_category'),
                      ), // IconButton
                    ],
                  ), // Row
                ],
              ), // Column
            ), // Container

            // Container( // 원래 아랫 부분
            //   height: bodyHeight * 0.4,
            //   width: maxWidth,
            //   padding: EdgeInsets.all(8.0),
            Expanded(
              // 원래 아랫 부분
              // flex: 1,
              child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('GPS 정보 재요청'),
                    onPressed: () {
                      _addFavoriteController.getPosition();
                      Common.unfocus(context);
                    },
                  ), // ElevatedButton

                        Text('GPS 정확도: ${_addFavoriteController.position.value.accuracy.round()} m '),
                        Text('위도: ${_addFavoriteController.position.value.latitude}'),
                        Text('경도: ${_addFavoriteController.position.value.longitude}'),
                ],
              ), // Column
            ), // Obx
            ), // Expanded
          ],
        ), // Column
      ), // Container
    ); // Scaffold
  } // build

  bool _checkFavoriteName(String value) {
    String errorMessage = '정상';

    if (value.length < 1) {
      errorMessage = '위치 이름은 반드시 입력해야 합니다.';
      log(errorMessage);
      Common.infoDialog(context, errorMessage);
      return false;
    } else if (value.length > 20) {
      errorMessage = '위치 이름은 최대 20자까지만 입력 가능합니다.';
      log(errorMessage);
      Common.infoDialog(context, errorMessage);
      return false;
    }
    return true;
  } // _chekckFavoriteName

} // class AddFavorite
