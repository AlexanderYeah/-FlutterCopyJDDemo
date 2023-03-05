import 'package:flutter/material.dart';
import '../../widget/jdProductButton.dart';
import '../../widget/jdTextField.dart';
import '../../services/screenAdaper.dart';

class RegisterFirstPage extends StatefulWidget {
  const RegisterFirstPage({super.key});

  @override
  State<RegisterFirstPage> createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "用户注册第一步",
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.width(48),
              ScreenAdapter.width(48),
              ScreenAdapter.width(48),
              ScreenAdapter.width(48)),
          child: ListView(
            children: [
              // logo 头像
              SizedBox(
                height: 10,
              ),
              // 输入框
              JdTextFiled(
                palceHolderStr: "请输入手机号",
                onChangeCallBack: (value) {},
              ),
              SizedBox(
                height: 40,
              ),
              JDProductButton(
                color: Colors.redAccent,
                text: "下一步",
                callback: () {
                  // 登录
                },
              ),
            ],
          ),
        ));
  }
}
