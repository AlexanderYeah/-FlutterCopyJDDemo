import 'package:flutter/material.dart';
import '../../widget/jdTextField.dart';
import '../../services/screenAdaper.dart';
import '../../widget/jdProductButton.dart';

class AddressAddPage extends StatefulWidget {
  const AddressAddPage({super.key});

  @override
  State<AddressAddPage> createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "新增收货地址",
              style: TextStyle(color: Colors.black87),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        body: Container(
          color: Color.fromRGBO(238, 238, 238, 1),
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              //用户名
              Container(
                height: ScreenAdapter.height(80),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: JdTextFiled(
                  palceHolderStr: "请输入姓名",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // 手机号
              Container(
                height: ScreenAdapter.height(80),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: JdTextFiled(
                  palceHolderStr: "请输入姓名",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // 详细地址
              Container(
                height: ScreenAdapter.height(140),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: JdTextFiled(
                  palceHolderStr: "请输入详细地址",
                  maxLines: 4,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // 提交按钮
              Container(
                width: ScreenAdapter.width(700),
                height: ScreenAdapter.height(80),
                child: JDProductButton(
                  color: Colors.redAccent,
                  text: "添加地址",
                  callback: () {
                    // 地址
                  },
                ),
              )
            ],
          ),
        ));
  }
}
