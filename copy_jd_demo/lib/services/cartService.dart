class CartService {
  static addCart(item) {
    //1 将对象转换为map 类型的数据
    var data = CartService.formatData(item);
    //2 将数据存储到本地 后面再购物车界面进行加载
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
    // 是否选中 默认选中
    map["checked"] = true;
    return map;
  }
}
