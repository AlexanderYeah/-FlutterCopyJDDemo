class CategoryItemModel {
  String? pid;
  String? title;
  String? pic;

  CategoryItemModel({this.pid, this.title, this.pic});

  CategoryItemModel.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    title = json['title'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['title'] = this.title;
    data['pic'] = this.pic;
    return data;
  }
}
