import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';

import 'Consts.dart';

showCustomToast(String message, [Color mColor]) {
  mColor ??= Color(0x99000000);
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    fontSize: 16.0,
    textColor: Colors.black,
  );
}

showAlertDialogWithCancel(
    BuildContext context, String message, Function onOKPressed) {
  PackageInfo _packageInfo = PackageInfo(
    appName: Consts.APP_NAME,
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  var buttonStyleOK = TextStyle(
    color: Colors.blue,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  var buttonStyleCancel = TextStyle(
    color: Colors.blue,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "OK",
      style: buttonStyleOK,
    ),
    onPressed: onOKPressed,
  );
  Widget cancelButton = TextButton(
    child: Text(
      "Cancel",
      style: buttonStyleCancel,
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    insetPadding: EdgeInsets.all(0),
    title: Text(_packageInfo.appName),
    content: Text(
      message,
      style: TextStyle(
        fontSize: 20,
        color: Color(0XFF1e1e1e),
      ),
    ),
    actions: [
      okButton,
      cancelButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Theme(
        data: Theme.of(context).copyWith(
          dialogBackgroundColor: Colors.white,
        ),
        child: Container(child: alert),
      );
    },
  );
}
