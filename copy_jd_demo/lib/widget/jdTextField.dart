import 'package:flutter/material.dart';
import '../services/screenAdaper.dart';

class JdTextFiled extends StatelessWidget {
  String? palceHolderStr;
  bool isPassword;
  var onChangeCallBack;
  int maxLines;
  JdTextFiled(
      {this.palceHolderStr,
      this.isPassword = false,
      this.onChangeCallBack = null,
      this.maxLines = 1,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  width: 1, color: Color.fromRGBO(233, 233, 233, 0.8))),
        ),
        height: ScreenAdapter.height(68),
        child: TextField(
          maxLines: this.maxLines,
          autofocus: true,
          obscureText: this.isPassword,
          decoration: InputDecoration(
              hintText: this.palceHolderStr,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none)),
          onChanged: this.onChangeCallBack,
        ));
  }
}
