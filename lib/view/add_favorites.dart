import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gobal/controller/add_favorites_controller.dart';

class AddFavorite extends StatefulWidget {
  const AddFavorite({Key? key}) : super(key: key);

  @override
  _AddFavoriteState createState() => _AddFavoriteState();
}

class _AddFavoriteState extends State<AddFavorite> {
  final AddFavoriteController addFavoriteController = Get.put(AddFavoriteController());

  @override
  void initState() {
    super.initState();
    // Future.delayed(
    //     Duration.zero, () async {
    //       position = await GpsInfo.instance.determinePosition();
    // }
    // );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('즐겨찾기에 위치 추가'),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            children: <Widget>[
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

              SizedBox(height: 10,),

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

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('카테고리'),
                  GetBuilder<AddFavoriteController>(
                    builder: (_) {
                  return Container(
                    width: 200,
                    height: 40,
                    child: DropdownButton(
                      isExpanded: true,
                      // hint: Text('카테고리 선택'),
                    value: AddFavoriteController.to.selectedCategoryId,
                    items: AddFavoriteController.to.groupList
                        .map((data) {
                    return DropdownMenuItem(
                    value: data.id,
                    child: Text(data.name),
                    );
                    },
                    ).toList(),
                    onChanged: (int? val) {
                        setState(() {  // GetBuilder를 사용하면 이상한 현상이 나타나서 setState로 사용하기로 결정함.
                          AddFavoriteController.to.selectGroupCode(val ?? 1); // 1: '일반'
                        });
                    },
                    ), // DropDownButton
                  );  // Container
            }
          ), // GetBuilder
                  ElevatedButton(
                    child: Text('카테고리 관리'),
                    onPressed: () {
                      Get.toNamed('/add_favorite/manage_category');
                    },
                  ), // ElevatedButton
                ],
              ), // Row

              SizedBox(height: 10,),
              Text(
                '현재 위치의 GPS 정보',
                // style: Theme.of(context).textTheme.headline3,
              ),
              ElevatedButton(
                child: Text('GPS 정보 재요청'),
                  onPressed: () async {
                  addFavoriteController.getPosition();
                  },
              ), // ElevatedButton
              GetBuilder<AddFavoriteController>(
                builder: (_) {
                  return Column(
                    children: <Widget>[
                      Text(
                        'GPS 정확도: ${_.position.accuracy.round()}',
                        // style: Theme.of(context).textTheme.headline4,
                      ),
                  Text(
                    '위도: ${_.position.latitude}',
                    // style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    '경도: ${_.position.longitude}',
                    // style: Theme.of(context).textTheme.headline4,
                  ),
                  ],
                  ); // Column
                },
              ), // GetBuilder
              SizedBox(height: 1,),
            ],
          ), // Column
        ), // GestureDetector
      ), // SafeArea
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

