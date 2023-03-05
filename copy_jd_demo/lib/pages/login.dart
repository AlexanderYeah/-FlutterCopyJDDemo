import 'package:copy_jd_demo/services/screenAdaper.dart';
import 'package:flutter/material.dart';
import '../widget/jdTextField.dart';
import '../widget/jdProductButton.dart';

class LoginPage extends StatefulWidget {
  String? palceHolderStr;
  bool isPassword;
  LoginPage({this.palceHolderStr, this.isPassword = false, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _palceHolderStr;
  bool _isPassword = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._palceHolderStr = widget.palceHolderStr;
    this._isPassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              )),
          title: Text(
            "登录",
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
                height: 60,
              ),
              Center(
                  child: ClipOval(
                child: Image.asset(
                  "images/logo.png",
                  width: 60,
                  height: 60,
                ),
              )),
              // logo 头像
              SizedBox(
                height: 30,
              ),
              // 输入框
              JdTextFiled(
                palceHolderStr: "请输入手机号",
                onChangeCallBack: (value) {},
              ),
              JdTextFiled(
                palceHolderStr: "请输入密码",
                isPassword: true,
                onChangeCallBack: (value) {
                  print(value);
                },
              ),
              SizedBox(
                height: 20,
              ),
              // 注册账号 忘记密码
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text("忘记密码"),
                    ),
                    onTap: () {
                      print("忘记密码");
                    },
                  )),
                  Expanded(
                      child: InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Text(
                        "新用户注册",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed("/registerFirst");
                    },
                  )),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              JDProductButton(
                color: Colors.redAccent,
                text: "登录",
                callback: () {
                  // 登录
                },
              ),
            ],
          ),
        ));
  }
}
