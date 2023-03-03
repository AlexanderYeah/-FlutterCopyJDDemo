import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import 'cartNumber.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdapter.height(160),
      width: ScreenAdapter.width(750),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
      child: Row(
        children: [
          // 选择框
          Container(
            margin: EdgeInsets.only(left: 5),
            width: ScreenAdapter.width(60),
            height: ScreenAdapter.height(60),
            child: Checkbox(
              value: false,
              onChanged: (isSelected) {},
              activeColor: Colors.redAccent,
            ),
          ),
          // 图片
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            width: ScreenAdapter.width(120),
            height: ScreenAdapter.width(120),
            child: Image.network(
              "https://imgservice.suning.cn/uimg1/b2c/image/mh_5GLu2Uex9j-uH19WnMg.jpg_800w_800h_4e",
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
                      "大风吹大风吹的大风吹的我的发型哈哈我的发型哈哈的大风吹的我的发型哈哈我的发型哈哈",
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
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                          child: Text(
                            "￥666",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, ScreenAdapter.width(15), 10),
                            child: CartNumber(),
                          ))
                      // 右边的数量组件
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
