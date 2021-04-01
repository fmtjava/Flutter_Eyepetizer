import 'package:flutter/material.dart';

//登录注册文本框封装
class LoginInputWidget extends StatefulWidget {
  final String hint;
  final bool obscureText;
  final ValueChanged<String> onChanged;

  const LoginInputWidget(
      {Key key, this.hint, this.obscureText = false, this.onChanged})
      : super(key: key);

  @override
  _LoginInputWidgetState createState() => _LoginInputWidgetState();
}

class _LoginInputWidgetState extends State<LoginInputWidget> {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            obscureText: widget.obscureText,
            autofocus: !widget.obscureText,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 15, right: 15),
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: TextStyle(color: Colors.grey)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Divider(
            height: 1,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }
}
