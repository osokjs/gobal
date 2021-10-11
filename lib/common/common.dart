import 'package:flutter/material.dart';

class Common {

  static void infoDialog(BuildContext context, String msg, {String? title}) async {
    await showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (context) {
      return AlertDialog(
        title: (title != null) ? Text(title) : const Text('알림창'),
        content: Text(msg),
        actions: <Widget>[
          ElevatedButton(
            child: Text('확인'),
            onPressed: () => Navigator.of(context).pop(),
          ), // ElevatedButton
        ],
      );
    },
    );
  } // infoDialog

  static Future<bool> confirmDialog(BuildContext context, String msg, {String? title, String? textConfirm}) async {
    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: (title != null) ? Text(title) : const Text('확인창'),
          content: Text(msg),
          actions: <Widget>[
            ElevatedButton(
              child: (textConfirm != null) ? Text(textConfirm) : const Text(
                  '확인'),
              onPressed: () => Navigator.of(context).pop(true),
            ), // ElevatedButton
            ElevatedButton(
              child: const Text('취소'),
              onPressed: () => Navigator.of(context).pop(false),
            ), // ElevatedButton
          ],
        );
      },
    );
  } // confirmDialog

  static void showSnackbar(BuildContext context, String content, {int? seconds}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: Colors.teal,
        duration: Duration(seconds: seconds ?? 30),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: '닫기',
          textColor: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  } // showSnackbar

  static void unfocus(BuildContext context) {
// Recommended Solution by Flutter Team.
    FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus &&
        currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

} // Common

