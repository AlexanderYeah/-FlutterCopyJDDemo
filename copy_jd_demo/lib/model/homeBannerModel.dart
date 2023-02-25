class HomeBannerModel {
  String? status;
  List<Banners>? banners;

  HomeBannerModel({this.status, this.banners});

  HomeBannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String? pic;

  Banners({this.pic});

  Banners.fromJson(Map<String, dynamic> json) {
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pic'] = this.pic;
    return data;
  }
}
