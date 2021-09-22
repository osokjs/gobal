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
        title: const Text('즐겨찾기에 현재 위치 추가'),
      ),
      body: Column(
        children: <Widget>[
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
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:<Widget>[
            ElevatedButton(
              child: Text('저장'),
                onPressed: () {
                String value = addFavoriteController.nameController.text.trim();
                if(!_isValid(context, value)) return;
                addFavoriteController.addFavorite(value, 1);
                Get.back();
                },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder( //모서리를 둥글게
                    borderRadius: BorderRadius.circular(20)),
                primary: Colors.blue,
                onPrimary: Colors.white, //글자색
                alignment: Alignment.centerLeft,
                textStyle: const TextStyle(fontSize: 30),
              ),
            ), // ElevatedButton
              ElevatedButton(
                child: Text('취소'),
                  onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder( //모서리를 둥글게
                      borderRadius: BorderRadius.circular(20)),
                  primary: Colors.blue,
                  onPrimary: Colors.white, //글자색
                  alignment: Alignment.centerLeft,
                  textStyle: const TextStyle(fontSize: 30),
                ),
              ), // ElevatedButton
    ],
          ), // Row
          SizedBox(
            height: 30,
          ),
          Text(
            '현재 위치의 GPS 정보',
            style: Theme.of(context).textTheme.headline3,
          ),
          ElevatedButton(
            child: Text('GPS 정보 재요청'),
              onPressed: () async {
              addFavoriteController.getPosition();
              },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder( //모서리를 둥글게
                  borderRadius: BorderRadius.circular(20)),
              primary: Colors.blue,
              onPrimary: Colors.white, //글자색
              alignment: Alignment.centerLeft,
              textStyle: const TextStyle(fontSize: 30),
            ),
          ), // ElevatedButton
          GetBuilder<AddFavoriteController>(
            builder: (_) {
              return Container(
                child:                    Column(
                  children: <Widget>[
                    Text(
                      'GPS 정확도: ${_.position.accuracy}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                Text(
                  '위도: ${_.position.latitude}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '경도: ${_.position.longitude}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
                ), // Column
              ); // Container
            },
          ), // Column

        ],
      ), // Column
    ); // Scaffold
  } // build

  bool _isValid(BuildContext context, String value)   {
    String errorMessage = '정상';

    if(value.length        <        1) {
      errorMessage = '위치 이름은 반드시 입력해야 합니다.';
      print(errorMessage);
      _showAlertDialog(context, errorMessage);
      return false;
    } else if(value.length        > 20) {
      errorMessage = '위치 이름은 최대 20자까지만 입력 가능합니다.';
      print(errorMessage);
      _showAlertDialog(context, errorMessage);
      return false;
    }
    return true;
  } // _isValid

  void _showAlertDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: Text('알림창'),
          content: Text('$content'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () => Get.back(),
            ), // ElevatedButton
          ],
        ); // AlertDialog
      },
    ); // showDialog
  } // _showAlertDialog


} // class AddFavorite

