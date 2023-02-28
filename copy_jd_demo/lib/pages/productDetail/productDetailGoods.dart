import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';

class ProductDetailGoodsPage extends StatefulWidget {
  const ProductDetailGoodsPage({super.key});

  @override
  State<ProductDetailGoodsPage> createState() => _ProductDetailGoodsPageState();
}

class _ProductDetailGoodsPageState extends State<ProductDetailGoodsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          // 图片
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Image.network(
                "http://s1.inewhope.com/images/202205/goods_img/81892_P_1653264710271.png",
                fit: BoxFit.fill),
          ),
          // 主标题
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text("飞利浦 SPB2180WB/93 新国标安全插座 8位总控",
                maxLines: 3,
                style: TextStyle(
                    color: Colors.black, fontSize: ScreenAdapter.fontSize(36))),
          ),
          // 副标题
          Container(
            padding: EdgeInsets.only(top: 3),
            child: Text("儿童保护门 插线板/插排/排插/接线板/拖线板 3米 居家办公超级实用(大品牌 值得信赖)",
                maxLines: 3,
                style: TextStyle(
                    color: Colors.black38,
                    fontSize: ScreenAdapter.fontSize(30))),
          ),
          // 价格
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text("惊爆价:"),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "¥28",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: ScreenAdapter.fontSize(44)),
                        )
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("原价:"),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "¥99",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: ScreenAdapter.fontSize(32)),
                        )
                      ],
                    ))
              ],
            ),
          ),
          // 已经选择的SKU
          Container(
            height: ScreenAdapter.height(80),
            child: Row(
              children: [
                Text(
                  "已选:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenAdapter.fontSize(32)),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "115, 黑色, XL, 1件 ",
                  style: TextStyle(fontSize: ScreenAdapter.fontSize(30)),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Container(
            height: ScreenAdapter.height(80),
            child: Row(
              children: [
                Text(
                  "运费:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenAdapter.fontSize(32)),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "免运费包邮",
                  style: TextStyle(fontSize: ScreenAdapter.fontSize(30)),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
