import 'dart:convert';

import 'storage.dart';

class CartService {
  static addCart(item) async {
    //1 将对象转换为map 类型的数据
    var data = CartService.formatData(item);
    //2 将数据存储到本地 后面再购物车界面进行加载
    /*
    逻辑梳理：
    1 获取本地存储的CartList 数据，看是否有数据
          有数据:1判断购物车有没有当前数据
                有当前数据：
                      1 让购物车中的当前数据数量等于以前的数据数量+现在的数量
                      2 重新写入到本地
                没有当前数据：
                      1 把购物车cartList的数据和当前的数据拼接，拼接后写入本地
          无数据:
          1 把当前商品数据放入到数组中写入到本地            
      
    */

    try {
      List cartListData = json.decode(await Storage.getString("cartList"));
      // 判断有没有当前 的数据
      bool hasData = cartListData.any((element) {
        // 判断商品是否相等 并且判断属性是否相等
        return element["title"] == data["title"] &&
            element["selectedAttr"] == data["selectedAttr"];
      });
      if (hasData) {
        print("hasData---hasData---hasData");
        // 有数据的话
        for (var i = 0; i < cartListData.length; i++) {
          if (cartListData[i]["title"] == data["title"] &&
              cartListData[i]["selectedAttr"] == data["selectedAttr"]) {
            // 修改数量
            cartListData[i]["cartCount"] = cartListData[i]["cartCount"] + 1;
          }
          await Storage.setString("cartList", json.encode(cartListData));
        }
      } else {
        // 没有数据
        cartListData.add(data);
        await Storage.setString("cartList", json.encode(cartListData));
      }
    } catch (error) {
      // ,没有数据直接写入
      List tempList = [];
      tempList.add(data);
      await Storage.setString("cartList", json.encode(tempList));
    }
  }

  // 格式化数据
  static formatData(item) {
    final Map map = Map<String, dynamic>();
    map["title"] = item.title;
    map["pic"] = item.imgs[0];
    map["subTitle"] = item.subTitle;
    map["price"] = item.price;
    map["saleCount"] = item.saleCount;
    map["selectedAttr"] = item.selectedAttr;
    map["cartCount"] = item.cartCount;
    // 是否选中 默认选中
    map["checked"] = true;
    print(map);
    return map;
  }
}
