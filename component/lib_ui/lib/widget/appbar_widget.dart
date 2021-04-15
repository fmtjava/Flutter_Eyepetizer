import 'package:flutter/material.dart';

appBar(String title, {bool showBack = true, List<Widget> actions}) {
  return AppBar(
    title: Text(title,
        style: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
    brightness: Brightness.light,
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.white,
    leading: showBack
        ? BackButton(
            color: Colors.black,
          )
        : null,
    actions: actions,
  );
}
