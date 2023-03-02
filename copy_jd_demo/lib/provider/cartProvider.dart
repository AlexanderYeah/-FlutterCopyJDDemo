import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProvider with ChangeNotifier {
  List _cartList = ["1111"];

  int get cartListCount => _cartList.length;

  // 添加数据
  addData(value) {
    this._cartList.add(value);
    notifyListeners();
  }

  // 删除数据
  deleteData(value) {
    this._cartList.remove(value);
    notifyListeners();
  }
}
