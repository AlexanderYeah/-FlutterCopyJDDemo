import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../../pages/login.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  static double moreItemWidth = ((ScreenAdapter.getScreenWidth() -
          ScreenAdapter.width(30) * 2 -
          ScreenAdapter.width(10) * 3)) /
      3;
  var moreItemHeight = moreItemWidth + ScreenAdapter.height(28);

  /*****---UI-----***/

  //用户头部
  Widget _userHeader() {
    return Container(
      width: double.infinity,
      height: ScreenAdapter.height(220),
      color: Colors.redAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: ScreenAdapter.width(40)),
              decoration: BoxDecoration(
                  border: Border.all(width: 1.3, color: Colors.white),
                  borderRadius: BorderRadius.circular(ScreenAdapter.width(60))),
              width: ScreenAdapter.width(120),
              height: ScreenAdapter.width(120),
              child: ClipOval(
                child: Image.asset(
                  "images/user_default.png",
                  fit: BoxFit.cover,
                ),
              )),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: InkWell(
            onTap: () {
              // 登录或者注册
              _loginOrRegisterAction();
            },
            child: Text(
              "登录/注册",
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenAdapter.fontSize(32)),
            ),
          )),
        ],
      ),
    );
  }

  // 订单状态按钮
  Widget _orderStatusBtn(title, iconData) {
    return Expanded(
        flex: 1,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: Colors.redAccent,
                size: ScreenAdapter.width(60),
              ),
              SizedBox(height: 7),
              Text(
                title,
                style: TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ));
  }

  /*****---Actions-----***/

  _loginOrRegisterAction() {
    Navigator.of(context).pushNamed("/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "我的",
          style: TextStyle(color: Colors.black),
        ),
        // 点击跳转搜索
      ),
      body: ListView(
        children: [
          _userHeader(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 我的订单模块
              Padding(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(30),
                    ScreenAdapter.height(20),
                    ScreenAdapter.width(30),
                    ScreenAdapter.width(5)),
                child: Text(
                  "我的订单",
                  style: TextStyle(fontSize: ScreenAdapter.fontSize(34)),
                ),
              ),
              Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(120),
                  padding: EdgeInsets.fromLTRB(
                      ScreenAdapter.width(30),
                      ScreenAdapter.width(5),
                      ScreenAdapter.width(30),
                      ScreenAdapter.width(5)),
                  child: Row(
                    children: [
                      _orderStatusBtn("待付款", Icons.payment),
                      _orderStatusBtn("待发货", Icons.local_shipping_rounded),
                      _orderStatusBtn("待收货", Icons.card_giftcard_rounded),
                      _orderStatusBtn("退款/售后", Icons.build_circle_rounded),
                    ],
                  ))
            ],
          ),
          // 分割线
          Container(
            width: double.infinity,
            height: ScreenAdapter.height(14),
            color: Color.fromRGBO(233, 233, 233, 1),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 更多功能模块
              Padding(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(30),
                    ScreenAdapter.height(20),
                    ScreenAdapter.width(30),
                    ScreenAdapter.width(5)),
                child: Text(
                  "更多功能",
                  style: TextStyle(fontSize: ScreenAdapter.fontSize(34)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(120),
                  padding: EdgeInsets.fromLTRB(
                      ScreenAdapter.width(30),
                      ScreenAdapter.width(5),
                      ScreenAdapter.width(30),
                      ScreenAdapter.width(5)),
                  child: Row(
                    children: [
                      _orderStatusBtn("我的足迹", Icons.history),
                      _orderStatusBtn("收藏商品", Icons.favorite),
                      _orderStatusBtn("我的地址", Icons.location_city),
                      _orderStatusBtn("联系客服", Icons.phone_iphone_rounded),
                    ],
                  )),
            ],
          ),
          // 分割线
          Container(
            width: double.infinity,
            height: ScreenAdapter.height(14),
            color: Color.fromRGBO(233, 233, 233, 1),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 更多功能模块
              Padding(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(30),
                    ScreenAdapter.height(20),
                    ScreenAdapter.width(30),
                    ScreenAdapter.width(5)),
                child: Text(
                  "设置",
                  style: TextStyle(fontSize: ScreenAdapter.fontSize(34)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(120),
                  padding: EdgeInsets.fromLTRB(
                      ScreenAdapter.width(30),
                      ScreenAdapter.width(5),
                      ScreenAdapter.width(30),
                      ScreenAdapter.width(5)),
                  child: Row(
                    children: [
                      _orderStatusBtn("版本检测", Icons.archive_rounded),
                      _orderStatusBtn("系统消息", Icons.message_rounded),
                      _orderStatusBtn("我的地址", Icons.location_city),
                      _orderStatusBtn("联系客服", Icons.phone_iphone_rounded),
                    ],
                  )),
              // 分割线
              Container(
                width: double.infinity,
                height: ScreenAdapter.height(14),
                color: Color.fromRGBO(233, 233, 233, 1),
              ),
            ],
          )
        ],
      ),
    );
  }
}
