class ProductDetailModel {
  String? title;
  List<String>? imgs;
  String? subTitle;
  double? price;
  double? oldPrice;
  int? saleCount;
  String? detainInfoUrl;
  List<ProductArrtributModel>? arrtributes;

  ProductDetailModel(
      {this.title,
      this.imgs,
      this.subTitle,
      this.price,
      this.oldPrice,
      this.saleCount,
      this.detainInfoUrl,
      this.arrtributes});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imgs = json['imgs'].cast<String>();
    subTitle = json['subTitle'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    saleCount = json['saleCount'];
    detainInfoUrl = json['detainInfoUrl'];
    if (json['arrtributes'] != null) {
      arrtributes = <ProductArrtributModel>[];
      json['arrtributes'].forEach((v) {
        arrtributes!.add(new ProductArrtributModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['imgs'] = this.imgs;
    data['subTitle'] = this.subTitle;
    data['price'] = this.price;
    data['oldPrice'] = this.oldPrice;
    data['saleCount'] = this.saleCount;
    data['detainInfoUrl'] = this.detainInfoUrl;
    if (this.arrtributes != null) {
      data['arrtributes'] = this.arrtributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductArrtributModel {
  String? cate;
  List<String>? list;

  ProductArrtributModel({this.cate, this.list});

  ProductArrtributModel.fromJson(Map<String, dynamic> json) {
    cate = json['cate'];
    list = json['list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cate'] = this.cate;
    data['list'] = this.list;
    return data;
  }
}
