class ProductListModel {
  String? status;
  List<ProductItemmModel>? result;

  ProductListModel({this.status, this.result});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ProductItemmModel>[];
      json['result'].forEach((v) {
        result!.add(new ProductItemmModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductItemmModel {
  String? title;
  String? pic;
  double? price;
  double? oldPrice;

  ProductItemmModel({this.title, this.pic, this.price, this.oldPrice});

  ProductItemmModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    pic = json['pic'];
    price = json['price'];
    oldPrice = json['oldPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['pic'] = this.pic;
    data['price'] = this.price;
    data['oldPrice'] = this.oldPrice;
    return data;
  }
}
