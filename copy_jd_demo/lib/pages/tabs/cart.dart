import 'package:flutter/material.dart';
import '../cart/cartItem.dart';
import '../cart/cartNumber.dart';
import 'package:provider/provider.dart';
import '../../provider/cartProvider.dart';
import '../../services/screenAdaper.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isDeleteFlag = false;
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    // 购物车列表
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "购物车",
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  setState(() {
                    _isDeleteFlag = !_isDeleteFlag;
                  });
                },
                icon: _isDeleteFlag
                    ? Icon(
                        Icons.edit,
                        color: Colors.black54,
                      )
                    : Icon(
                        Icons.edit,
                        color: Colors.black54,
                      ))
          ],
        ),
        body: cartProvider.cartList.length != 0
            ? Stack(
                //
                children: [
                  // 上面是列表
                  ListView(
                      children: cartProvider.cartList.map((value) {
                    return CartItem(itemData: value);
                  }).toList()),
                  // 定位到下面是浮动的结算栏
                  Positioned(
                      bottom: 0,
                      width: ScreenAdapter.width(750),
                      height: ScreenAdapter.height(80),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(
                                    width: 1,
                                    color:
                                        Color.fromRGBO(242, 242, 242, 0.8)))),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Checkbox(
                                    onChanged: (value) {
                                      cartProvider.checkedAll(value);
                                    },
                                    activeColor: Colors.redAccent,
                                    value: cartProvider.isCheckedAll,
                                  ),
                                ),
                                Text(
                                  "全选",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                // 保存两位小数
                                Text(
                                  "合计:￥" +
                                      cartProvider.totalPrice
                                          .toStringAsFixed(2),
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: ScreenAdapter.fontSize(32)),
                                ),
                              ],
                            ),
                            // 如果编辑的话 显示删除  否则显示结算
                            _isDeleteFlag == false
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 13),
                                      alignment: Alignment.center,
                                      width: ScreenAdapter.width(138),
                                      height: ScreenAdapter.height(50),
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Text(
                                        "立即结算",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ))
                                : Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                        margin: EdgeInsets.only(right: 13),
                                        alignment: Alignment.center,
                                        width: ScreenAdapter.width(138),
                                        height: ScreenAdapter.height(50),
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: InkWell(
                                          onTap: () {
                                            cartProvider.deleteItem();
                                          },
                                          child: Text(
                                            "删除",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )))
                          ],
                        ),
                      )),
                ],
              )
            : Center(
                child: Text("购物车空空如也"),
              ));
  }
}
