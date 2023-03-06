import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import '../../widget/jdTextField.dart';
import '../../services/screenAdaper.dart';
import '../../widget/jdProductButton.dart';
import 'package:city_pickers/city_pickers.dart';

class AddressAddPage extends StatefulWidget {
  const AddressAddPage({super.key});

  @override
  State<AddressAddPage> createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String _selectedAddressStr = "";
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
              //
              SizedBox(
                height: 15,
              ),
              //选择地区
              Container(
                height: ScreenAdapter.height(80),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: InkWell(
                    onTap: () async {
                      Result? result = await CityPickers.showCityPicker(
                        context: context,
                        cancelWidget: Text(
                          "取消",
                          style: TextStyle(color: Colors.black87),
                        ),
                        confirmWidget: Text(
                          "确认",
                          style: TextStyle(color: Colors.black87),
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          this._selectedAddressStr = "${result.provinceName}" +
                              "${result.cityName}" +
                              "${result.areaName}";
                        });
                      }

                      print(result);
                    },
                    child: Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                this._selectedAddressStr.length > 0
                                    ? this._selectedAddressStr
                                    : "请选择省市区",
                                style: TextStyle(
                                    color: this._selectedAddressStr.length > 0
                                        ? Colors.black
                                        : Colors.black87,
                                    fontSize: ScreenAdapter.fontSize(30)),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 12),
                                  child: Icon(Icons.navigate_next),
                                ))
                          ],
                        ))),
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
