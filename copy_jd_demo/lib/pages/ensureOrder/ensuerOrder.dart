import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../../widget/jdProductButton.dart';
import '../../provider/ensureOrderProvider.dart';
import 'package:provider/provider.dart';

class EnsureOrderpage extends StatefulWidget {
  const EnsureOrderpage({super.key});

  @override
  State<EnsureOrderpage> createState() => _EnsureOrderpageState();
}

class _EnsureOrderpageState extends State<EnsureOrderpage> {
  EnsureOrderProvider? _ensureOrderPrivider;
  @override
  Widget _productItem(element) {
    return Container(
      margin: EdgeInsets.only(top: 1),
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
              element["pic"],
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
                      "${element["title"]}",
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
                                  "￥${element["price"]}",
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                // 属性
                                Text(
                                  "${element["selectedAttr"]}",
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
                          child: Text("x${element["cartCount"]}"),
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

  Widget _sectionTitleWidget(title) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: ScreenAdapter.fontSize(32)),
        ),
      ),
    );
  }

  // 结算信息item
  Widget _orderMoneyInfoItemWidget(title, content, color) {
    return Container(
      child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: ScreenAdapter.fontSize(28),
                      color: Colors.black54),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  content,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: ScreenAdapter.fontSize(28), color: color),
                ),
              )
            ],
          )),
    );
  }

  Widget build(BuildContext context) {
    this._ensureOrderPrivider = Provider.of<EnsureOrderProvider>(context);

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
                      height:
                          this._ensureOrderPrivider!.ensureOrderList.length *
                                  108 +
                              30,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitleWidget("结算商品"),
                          //
                          SizedBox(
                            height: 2,
                          ),
                          Column(
                            children: this
                                ._ensureOrderPrivider!
                                .ensureOrderList
                                .map((element) {
                              return _productItem(element);
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                    // 商品订单结算信息
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: ScreenAdapter.height(210),
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitleWidget("结算信息"),
                          _orderMoneyInfoItemWidget(
                              "运费:", "包邮免运费", Colors.black54),
                          _orderMoneyInfoItemWidget(
                              "折扣:", "立减￥0元", Colors.black54),
                          _orderMoneyInfoItemWidget(
                              "总价:",
                              "¥${_ensureOrderPrivider!.totalPrice}",
                              Colors.redAccent),
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
                                  "",
                                  style: TextStyle(
                                      fontSize: ScreenAdapter.fontSize(34),
                                      color: Colors.white),
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
