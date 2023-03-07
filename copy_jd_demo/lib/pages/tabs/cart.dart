import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../cart/cartItem.dart';
import '../cart/cartNumber.dart';
import 'package:provider/provider.dart';
import '../../provider/cartProvider.dart';
import '../../services/screenAdaper.dart';
import '../../provider/ensureOrderProvider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isDeleteFlag = false;
  @override

  /*****---购物车位空-----***/
  Widget _emptyDataWidget() {
    return Container(
      color: Colors.white,
      width: ScreenAdapter.width(750),
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
          ),
          Container(
            width: ScreenAdapter.width(100),
            height: ScreenAdapter.width(100),
            child: Image.asset(
              "images/cart_empty.png",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: ScreenAdapter.width(400),
            height: ScreenAdapter.height(80),
            child: Text(
              "空空如也,赶快去逛逛吧",
              style: TextStyle(fontSize: ScreenAdapter.fontSize(30)),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: ScreenAdapter.width(400),
            height: ScreenAdapter.height(80),
            child: Text(
              "/ 你 / 可 / 能 / 会 / 喜 / 欢",
              style: TextStyle(fontSize: ScreenAdapter.fontSize(30)),
              textAlign: TextAlign.center,
            ),
          ),
          // 商品列表
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    EnsureOrderProvider ensureOrderProvider =
        Provider.of<EnsureOrderProvider>(context);
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
                                        child: InkWell(
                                          child: Text(
                                            "立即结算",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onTap: () async {
                                            // 1 获取购物车选中的数据
                                            List selectedList =
                                                await CartProvider
                                                    .getCartSelectedData();
                                            print(selectedList);
                                            // 2 保存购物车的数据 另一个页面可以获取
                                            ensureOrderProvider
                                                .changeEnsureOrderData(
                                                    selectedList);
                                            // 3 如果有选中的数据才进行跳转 没有的话则不进行跳转
                                            if (selectedList.length > 0) {
                                              // 跳转操作
                                              Navigator.of(context)
                                                  .pushNamed("/ensureOrder");
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "请选择结算商品",
                                                  gravity: ToastGravity.CENTER);
                                            }
                                          },
                                        )))
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
            : _emptyDataWidget());
  }
}
