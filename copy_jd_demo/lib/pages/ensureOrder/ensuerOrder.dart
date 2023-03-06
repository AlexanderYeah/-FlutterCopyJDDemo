import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../../widget/jdProductButton.dart';

class EnsureOrderpage extends StatefulWidget {
  const EnsureOrderpage({super.key});

  @override
  State<EnsureOrderpage> createState() => _EnsureOrderpageState();
}

class _EnsureOrderpageState extends State<EnsureOrderpage> {
  @override
  Widget _productItem() {
    return Container(
      margin: EdgeInsets.only(top: 7),
      padding: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Color.fromRGBO(238, 238, 238, 1),
        width: 1,
      ))),
      child: Row(
        children: [
          // 图片
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            width: ScreenAdapter.width(120),
            height: ScreenAdapter.width(120),
            child: Image.network(
              "https://hbimg.huabanimg.com/07b029c67010c0a17a1c78fcbc92ce612de4cf3ae8dd-Oc4KXC_fw658",
              fit: BoxFit.cover,
            ),
          ),
          // 后面的部分为自适应的 所以分为列 1比1 展示
          Expanded(
              flex: 1,
              child: Column(
                // 靠左排列
                crossAxisAlignment: CrossAxisAlignment.start,
                // 上下的间距 一个定位在上面 一个定位在下面
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 12, 10, 2),
                    child: Text(
                      "大风火车",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Stack(
                    children: [
                      // 左边的价格
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            margin: EdgeInsets.fromLTRB(10, 12, 0, 10),
                            child: Row(
                              children: [
                                // 价格
                                Text(
                                  "￥9998",
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                // 属性
                                Text(
                                  "红色",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: ScreenAdapter.fontSize(26)),
                                ),
                              ],
                            )),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              0, 14, ScreenAdapter.width(15), 15),
                          child: Text("x2"),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "订单结算",
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
            color: Color.fromRGBO(232, 232, 232, 1),
            child: Stack(
              children: [
                ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: ScreenAdapter.height(120),
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Container(
                        margin: EdgeInsets.only(top: 2),
                        child: ListTile(
                          leading: Icon(
                            Icons.add_location,
                            color: Colors.redAccent,
                          ),
                          title: Text("请添加收货地址"),
                          subtitle: Text("data"),
                          trailing: Icon(Icons.navigate_next),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 300,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                              child: Text(
                                "选购商品",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: ScreenAdapter.fontSize(32)),
                              ),
                            ),
                          ),
                          //
                          SizedBox(
                            height: 2,
                          ),
                          _productItem(),
                          _productItem(),
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                    bottom: 0,
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(100),
                    child: Container(
                        width: ScreenAdapter.width(750),
                        height: ScreenAdapter.height(100),
                        color: Colors.white,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  "总价:1231",
                                  style: TextStyle(
                                      fontSize: ScreenAdapter.fontSize(34),
                                      color: Colors.redAccent),
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: ElevatedButton(
                                      child: Text(
                                        "提交订单",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: null,
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.redAccent))),
                                ))
                          ],
                        ))),
              ],
            )));
  }
}
