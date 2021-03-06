import 'package:flutter/material.dart';

alert(BuildContext context, String msg, {String title, Function callback}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(
            title =! null ? title : "Carros",
          ),
          content: Text(
            msg,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.pop(context);

                if (callback != null) {
                  callback();
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
