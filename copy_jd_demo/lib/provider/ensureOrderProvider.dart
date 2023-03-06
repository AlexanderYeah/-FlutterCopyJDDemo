import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnsureOrderProvider with ChangeNotifier {
  List _ensureOrderList = [];

  List get ensureOrderList => this._ensureOrderList;
  // 总价格
  double totalPrice = 0;
  //保存数据
  changeEnsureOrderData(listData) {
    this._ensureOrderList = listData;
    // 计算总价
    calculateTotalPrice();
    notifyListeners();
  }

  // 计算商品的价格
  // 计算总价格
  calculateTotalPrice() {
    double tempTotalPrice = 0;
    for (var i = 0; i < this.ensureOrderList.length; i++) {
      tempTotalPrice = tempTotalPrice +
          this.ensureOrderList[i]["price"] *
              this.ensureOrderList[i]["cartCount"];
    }
    this.totalPrice = tempTotalPrice;
    notifyListeners();
  }
}
