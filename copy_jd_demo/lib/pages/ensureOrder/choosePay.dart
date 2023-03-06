import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class ChoosePayPage extends StatefulWidget {
  const ChoosePayPage({super.key});

  @override
  State<ChoosePayPage> createState() => _ChoosePayPageState();
}

class _ChoosePayPageState extends State<ChoosePayPage> {
  @override

  /*****---UI-----**/

  Widget _payHeaderWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      width: ScreenAdapter.width(688),
      height: ScreenAdapter.height(200),
      child: Column(
        children: [
          SizedBox(height: ScreenAdapter.height(40)),
          Container(
            child: Text(
              "需支付金额(元)",
              style: TextStyle(
                  color: Colors.black54, fontSize: ScreenAdapter.fontSize(32)),
            ),
          ),
          SizedBox(height: ScreenAdapter.height(20)),
          Container(
            child: Text(
              "￥889.9",
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: ScreenAdapter.fontSize(60)),
            ),
          ),
          SizedBox(height: ScreenAdapter.height(20)),
        ],
      ),
    );
  }

  Widget _payMethodWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      width: ScreenAdapter.width(688),
      height: ScreenAdapter.height(330),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ScreenAdapter.height(20)),
          Container(
            height: ScreenAdapter.height(40),
            margin: EdgeInsets.fromLTRB(16, 0, 16, 5),
            child: Text(
              "请选择支付方式",
              style: TextStyle(
                  color: Colors.black54, fontSize: ScreenAdapter.fontSize(32)),
            ),
          ),
          SizedBox(height: ScreenAdapter.height(0)),
          Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color.fromRGBO(238, 238, 238, 1)))),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
              height: ScreenAdapter.height(120),
              child: Center(
                child: ListTile(
                  leading: Image.asset(
                    "images/logo.png",
                    width: ScreenAdapter.width(90),
                    height: ScreenAdapter.width(90),
                    fit: BoxFit.fill,
                  ),
                  title: Text(
                    "支付宝",
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(36),
                        color: Colors.black87),
                  ),
                  trailing: RoundCheckBox(
                    size: 30,
                    onTap: (value) {},
                    isChecked: true,
                    checkedColor: Colors.redAccent,
                  ),
                ),
              )),
          Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
              height: ScreenAdapter.height(120),
              child: Center(
                child: ListTile(
                  leading: Image.asset(
                    "images/logo.png",
                    width: ScreenAdapter.width(90),
                    height: ScreenAdapter.width(90),
                    fit: BoxFit.fill,
                  ),
                  title: Text(
                    "微信",
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(36),
                        color: Colors.black87),
                  ),
                  trailing: Checkbox(value: true, onChanged: null),
                ),
              )),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "支付方式",
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
        width: ScreenAdapter.width(750),
        height: double.infinity,
        color: Color.fromRGBO(238, 238, 238, 1),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _payHeaderWidget(),
            SizedBox(
              height: 20,
            ),
            _payMethodWidget(),
          ],
        ),
      ),
    );
  }
}
