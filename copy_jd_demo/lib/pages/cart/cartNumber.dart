import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cartProvider.dart';
import '../../services/screenAdaper.dart';

class CartNumber extends StatefulWidget {
  var itemData;

  CartNumber({super.key, this.itemData});
  @override
  State<CartNumber> createState() => _CartNumberState();
}

class _CartNumberState extends State<CartNumber> {
  var _itemData;
  var cartProvider;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.cartProvider = Provider.of<CartProvider>(context);
    this._itemData = widget.itemData;
    Widget _leftBtn() {
      return InkWell(
        onTap: () {
          // 加法
          this._itemData["cartCount"] = this._itemData["cartCount"] <= 1
              ? 1
              : this._itemData["cartCount"] - 1;
          setState(() {
            this.cartProvider.changeCartItemCount();
          });
        },
        child: Container(
          alignment: Alignment.center,
          width: ScreenAdapter.width(45),
          height: ScreenAdapter.height(45),
          child: Text("-"),
        ),
      );
    }

    Widget _rightBtn() {
      return InkWell(
          onTap: () {
            // 加法
            this._itemData["cartCount"] += 1;
            setState(() {
              this.cartProvider.changeCartItemCount();
            });
          },
          child: Container(
            alignment: Alignment.center,
            width: ScreenAdapter.width(45),
            height: ScreenAdapter.height(45),
            child: Text("+"),
          ));
    }

    Widget _centerArea() {
      return Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(70),
        height: ScreenAdapter.height(45),
        child: Text("${_itemData["cartCount"]}"),
        decoration: BoxDecoration(
            border: Border(
          left: BorderSide(width: 1, color: Colors.black12),
          right: BorderSide(width: 1, color: Colors.black12),
        )),
      );
    }

    return Container(
      height: ScreenAdapter.height(45),
      // 160 + 边框的宽度
      width: ScreenAdapter.width(164),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[_leftBtn(), _centerArea(), _rightBtn()],
      ),
    );
  }
}
