import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobal/controller/add_favorites_controller.dart';

class AddFavorite extends StatelessWidget {
  final AddFavoriteController addFavoriteController = Get.put(AddFavoriteController());

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
        title: const Text('즐겨찾기에 위치 추가'),
      ),
      body: GestureDetector(
        onTap: () {
          // FocusScope.of(context).unfocus();
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: <Widget>[
            Container( // 윗 부분
        height: bodyHeight * 0.6,
          width: maxWidth,
          padding: EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text('저장'),
                        onPressed: () {
                          String value = addFavoriteController.nameController.text.trim();
                          if(!_checkFavoriteName(value)) return;
                          addFavoriteController.addFavoriteData(value);
                          // Get.back();
                        },
                      ), // ElevatedButton
                      ElevatedButton(
                        child: Text('취소'),
                        onPressed: () => Get.back(),
                      ), // ElevatedButton
                    ],
                  ), // Row

            // SizedBox(height: 10,),

            Expanded(
              child: TextField(
                controller: addFavoriteController.nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '위치 이름:',
                  hintText: '위치 이름을 20자 이내로 입력하세요.',
                ),
              ), // TextField
            ), // Expanded

            // SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('카테고리'),
        //         GetBuilder<AddFavoriteController>(
        //           builder: (_) {
        //         return Container(
        //           width: 200,
        //           height: 40,
        //           child: DropdownButton(
        //             isExpanded: true,
        //             // hint: Text('카테고리 선택'),
        //           value: AddFavoriteController.to.selectedCategoryId,
        //           items: AddFavoriteController.to.groupList
        //               .map((data) {
        //           return DropdownMenuItem(
        //           value: data.id,
        //           child: Text(data.name),
        //           );
        //           },
        //           ).toList(),
        //           onChanged: (int? val) {
        //                 AddFavoriteController.to.selectGroupCode(val ?? 1); // 1: '일반'
        //           },
        //           ), // DropDownButton
        //         );  // Container
        //   }
        // ), // GetBuilder
                ElevatedButton(
                  child: Text('...'),
                  onPressed: () {
                    Get.toNamed('/add_favorite/manage_category');
                  },
                ), // ElevatedButton
              ],
            ), // Row
                ],
              ), // Column
            ), // Container

            // SizedBox(height: 10,),

            // Container( // 아랫 부분
            //   height: bodyHeight * 0.4,
            //   width: maxWidth,
            //   padding: EdgeInsets.all(5.0),
              Expanded( // 아랫 부분
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('현재 위치의 GPS 정보'),
            ElevatedButton(
              child: Text('GPS 정보 재요청'),
                onPressed: () async {
                addFavoriteController.getPosition();
                },
            ), // ElevatedButton
                    ],
                  ), // Row
    GetBuilder<AddFavoriteController>(
    builder: (_ctrl) => Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('GPS 정확도: ${_ctrl.position.accuracy.round()}'),
    Text('위도: ${_ctrl.position.latitude}'),
    Text('경도: ${_ctrl.position.longitude}'),
          ],
        ), // Column
        ), // GetBuilder
                  ],
                  ), // Column
            ), // Container
          ],
        ), // Column
      ), // GestureDetector
    ); // Scaffold
  } // build

  bool _checkFavoriteName(String value)   {
    String errorMessage = '정상';

    if(value.length        <        1) {
      errorMessage = '위치 이름은 반드시 입력해야 합니다.';
      log(errorMessage);
      // _showAlertDialog(context, errorMessage);
      return false;
    } else if(value.length        > 20) {
      errorMessage = '위치 이름은 최대 20자까지만 입력 가능합니다.';
      log(errorMessage);
      // _showAlertDialog(context, errorMessage);
      return false;
    }
    return true;
  } // _chekckFavoriteName


} // class AddFavorite

