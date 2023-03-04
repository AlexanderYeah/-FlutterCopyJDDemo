import 'package:copy_jd_demo/model/productDetailModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/screenAdaper.dart';
import 'cartNumber.dart';
import '../../provider/cartProvider.dart';

class CartItem extends StatefulWidget {
  Map itemData;
  CartItem({required this.itemData, super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Map _itemData = {};
  var cartProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._itemData = widget.itemData;
  }

  @override
  Widget build(BuildContext context) {
    this.cartProvider = Provider.of<CartProvider>(context);

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
              value: _itemData["checked"],
              onChanged: (isSelected) {
                // 取反操作
                setState(() {
                  _itemData["checked"] = !_itemData["checked"];
                });
                this.cartProvider.itemChange();
              },
              activeColor: Colors.redAccent,
            ),
          ),
          // 图片
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            width: ScreenAdapter.width(120),
            height: ScreenAdapter.width(120),
            child: Image.network(
              _itemData["pic"],
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
                      "${_itemData["title"]}",
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
                            child: Row(
                              children: [
                                // 价格
                                Text(
                                  "￥${_itemData["price"]}",
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                // 属性
                                Text(
                                  "${_itemData["selectedAttr"]}",
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
                              0, 0, ScreenAdapter.width(15), 10),
                          child: CartNumber(itemData: _itemData),
                        ),
                      ),
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
