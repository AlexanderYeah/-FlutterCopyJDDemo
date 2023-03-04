import 'dart:convert';

import 'package:copy_jd_demo/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProvider with ChangeNotifier {
  List cartList = [];

  int get cartListCount => cartList.length;

  // 初始化的时候加载数据
  CartProvider() {
    this.init();
  }

  //
  init() async {
    // 加载购物车的数据
    try {
      List cartListData = json.decode(await Storage.getString("cartList"));
      print("cartList---cartList");
      print(cartList);
      this.cartList = cartListData;
    } catch (error) {
      print(error);
    }
    // 更新数据
    notifyListeners();
  }

  // 更新数据
  updateList() {
    this.init();
  }

  // 添加数据
  addData(value) {
    this.cartList.add(value);
    notifyListeners();
  }

  // 删除数据
  deleteData(value) {
    this.cartList.remove(value);
    notifyListeners();
  }
}
