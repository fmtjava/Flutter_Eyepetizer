
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/util/commom_uitl.dart';

class LoginPageModel extends ChangeNotifier {
  String userName;
  String password;
  bool loginEnable = false;

  void setUserName(String name) {
    this.userName = name;
    checkInput();
  }

  void setPassword(String password) {
    this.password = password;
    checkInput();
  }

  void checkInput() {
    bool enable;
    if (!isEmpty(userName) && !isEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    loginEnable = enable;
    notifyListeners();
  }

  void login(){

  }
}
