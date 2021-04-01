import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/config/string.dart';
import 'package:flutter_eyepetizer/viewmodel/login_page_model.dart';
import 'package:flutter_eyepetizer/widget/appbar_widget.dart';
import 'package:flutter_eyepetizer/widget/login_input_widget.dart';
import 'package:flutter_eyepetizer/widget/provider_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(DString.login, showBack: false, actions: [
        InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 15),
              child: Text(
                DString.register,
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ))
      ]),
      body: ProviderWidget<LoginPageModel>(
        model: LoginPageModel(),
        builder: (context, model, child) {
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80, bottom: 15),
                child: Image.asset(
                  'images/ic_login_icon.png',
                  width: 100,
                  height: 100,
                ),
              ),
              LoginInputWidget(
                hint: DString.please_input_name,
                onChanged: (value) {
                  model.setUserName(value);
                },
              ),
              LoginInputWidget(
                hint: DString.please_input_password,
                obscureText: true,
                onChanged: (value) {
                  model.setPassword(value);
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, top: 40, right: 30),
                child: MaterialButton(
                  height: 45,
                  color: model.loginEnable ? Colors.black87 : Colors.grey,
                  onPressed: () => model.loginEnable ? login(model) : null,
                  child: Text(
                    DString.login,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  login(LoginPageModel model) {
    model.login();
  }

}
