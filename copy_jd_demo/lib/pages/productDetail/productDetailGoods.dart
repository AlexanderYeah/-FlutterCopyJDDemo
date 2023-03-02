import 'package:copy_jd_demo/localData/productDetailData.dart';
import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../../widget/jdProductButton.dart';
import '../../model/productDetailModel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ProductDetailGoodsPage extends StatefulWidget {
  var model;
  ProductDetailGoodsPage({super.key, this.model});

  @override
  State<ProductDetailGoodsPage> createState() => _ProductDetailGoodsPageState();
}

class _ProductDetailGoodsPageState extends State<ProductDetailGoodsPage> {
  @override
  ProductDetailModel _detailModel = ProductDetailModel();
  // 选中的值
  String _selectedAttrValue = "";
  List _attr = [];

  /*****---DataHandle-----***/
  @override
  void initState() {
    super.initState();
    _detailModel = widget.model;
    this._attr = this._detailModel.arrtributes!;
    _loadAttrData();
  }
  /*
  将数据构造成这样的数据 
  [{title: 红色, checked: true}, {title: 绿色, checked: false}, {title: 蓝色, checked: false}, {title: 橙色, checked: false}, {title: 紫色, checked: false}, {title: 灰色, checked: false}]
  */

  // 获取选中的值
  _getSelectedAttrValue() {
    List tempList = [];
    for (var i = 0; i < _detailModel.arrtributes!.length; i++) {
      var tempModel = _detailModel.arrtributes![i];
      for (var j = 0; j < tempModel.attrList!.length; j++) {
        var tempMap = tempModel.attrList![j];
        if (tempMap["checked"] == true) {
          tempList.add(tempMap["title"]);
        }
      }
    }
    setState(() {
      this._selectedAttrValue = tempList.join(",");
    });
  }

  _loadAttrData() {
    var attr = this._attr;
    for (var i = 0; i < _detailModel.arrtributes!.length; i++) {
      var tempModel = _detailModel.arrtributes![i];
      for (var j = 0; j < tempModel.list!.length; j++) {
        var tempName = tempModel.list![j];
        bool isChecked = j == 0 ? true : false;
        var map1 = {"title": tempName, "checked": isChecked};
        // 改造数据格式
        attr[i].attrList!.add(map1);
      }
    }
    print(this._attr[0].cate);
    print(this._attr[0].attrList);
  }

  // 点击改变属性的值
  _changeAttr(cate, title, setBottomState) {
    // 接收到点击的分类和哪一项之后 去改变数据

    for (var i = 0; i < _detailModel.arrtributes!.length; i++) {
      var tempModel = _detailModel.arrtributes![i];
      if (cate == tempModel.cate) {
        for (var j = 0; j < tempModel.attrList!.length; j++) {
          var tempName = tempModel.attrList![j]["title"];
          var tempMap = tempModel.attrList![j];

          // bool isChecked = false;
          if (tempName == title) {
            tempMap["checked"] = true;
          } else {
            tempMap["checked"] = false;
          }
        }
      }
    }

    setBottomState(() {
      /*
      这里无法重新渲染底部弹出的组件,两种方案,一种是状态管理，一种是statefulBuilder
      */
      this._attr = _detailModel.arrtributes!;
    });
  }

  List<Widget> _getAttributeWidget(element, setBottomState) {
    List<Widget> tempList = [];
    for (var i = 0; i < element.attrList.length; i++) {
      print("object--${element.attrList[i]}");
      Map tempMap = element.attrList[i];
      tempList.add(InkWell(
        onTap: () {
          _changeAttr(element.cate, tempMap["title"], setBottomState);
        },
        child: Container(
          margin: EdgeInsets.all(5),
          child: Chip(
            label: Text(
              "${tempMap["title"]}",
              style: TextStyle(
                  color: tempMap["checked"] == true
                      ? Colors.white
                      : Colors.black54,
                  fontSize: ScreenAdapter.fontSize(28)),
            ),
            padding: EdgeInsets.all(5),
            backgroundColor: tempMap["checked"] == true
                ? Colors.redAccent
                : Color.fromRGBO(233, 233, 233, 1),
          ),
        ),
      ));
    }

    return tempList;
  }

  List<Widget> _categoryWidget(setBottomState) {
    List<Widget> tempList = [];

    // 初始化数据

    this._attr.forEach((element) {
      tempList.add(Wrap(
        children: [
          Wrap(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 18, 0, 0),
                width: ScreenAdapter.width(100),
                child: Text(
                  "${element.cate}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenAdapter.fontSize(32)),
                ),
              ),
            ],
          ),
          Container(
              width: ScreenAdapter.width(586),
              child: Wrap(
                children: _getAttributeWidget(element, setBottomState),
              ))
        ],
      ));
    });
    return tempList;
  }

  /*****----Actions-----***/
  // 底部踏出菜单 高度具体多少 还是要根据服务端的数据进行一个计算比较合适
  _showFilterBottomView(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          // 在这里加载一个 StatefulBuilder 避免主页面渲染不了弹出界面的数据
          return StatefulBuilder(
              builder: (BuildContext context, setBottomState) {
            return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  // 点击不消失
                  // Navigator.of(context).pop();
                },
                child: Stack(
                  children: [
                    // 上方的选择条件
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(10),
                      child: ListView(
                          // 使用warp 嵌套 wrap 的方式
                          // 这个地方把state 传递过去
                          children: _categoryWidget(setBottomState)),
                    ),
                    // 下方的按钮
                    Positioned(
                        bottom: 0,
                        width: ScreenAdapter.width(750),
                        height: ScreenAdapter.height(90),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Color.fromRGBO(233, 233, 233, 1),
                                      width: 1))),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: JDProductButton(
                                    color: Color.fromRGBO(253, 1, 0, 0.9),
                                    text: "加入购物车",
                                    callback: () {
                                      print("加入购物车");
                                      _getSelectedAttrValue();
                                      Navigator.of(context).pop();
                                    },
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: JDProductButton(
                                    color: Color.fromRGBO(255, 165, 0, 0.9),
                                    text: "立即购买",
                                    callback: () {
                                      _getSelectedAttrValue();
                                      print("立即购买");
                                      Navigator.of(context).pop();
                                    },
                                  ))
                            ],
                          ),
                        ))
                  ],
                ));
          });
        });
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: ListView(
        children: <Widget>[
          // 图片
          AspectRatio(
              aspectRatio: 1 / 1,
              child: Swiper(
                // 分页器
                pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        space: 5,
                        color: Colors.white,
                        activeColor: Colors.redAccent,
                        activeSize: 13)),

                itemCount: this._detailModel.imgs!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(this._detailModel.imgs![index],
                      fit: BoxFit.fill);
                },
              )),
          // 主标题
          Container(
            margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
            // padding: EdgeInsets.only(top: 10),
            child: Text(_detailModel.title!,
                maxLines: 3,
                style: TextStyle(
                    color: Colors.black, fontSize: ScreenAdapter.fontSize(36))),
          ),
          // 副标题
          Container(
            margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
            padding: EdgeInsets.only(top: 1),
            child: Text(_detailModel.subTitle!,
                maxLines: 3,
                style: TextStyle(
                    color: Colors.black38,
                    fontSize: ScreenAdapter.fontSize(30))),
          ),
          // 价格
          Container(
            margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text("惊爆价:"),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "¥${this._detailModel.price}",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: ScreenAdapter.fontSize(44)),
                        )
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("原价:"),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "¥${this._detailModel.oldPrice}",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: ScreenAdapter.fontSize(32)),
                        )
                      ],
                    ))
              ],
            ),
          ),
          // 已经选择的SKU
          InkWell(
            onTap: () {
              _showFilterBottomView(context);
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
              height: ScreenAdapter.height(80),
              child: Row(
                children: [
                  Text(
                    "已选:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenAdapter.fontSize(32)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    this._selectedAttrValue.length == 0
                        ? "请选择"
                        : "${this._selectedAttrValue}",
                    style: TextStyle(fontSize: ScreenAdapter.fontSize(30)),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
            height: ScreenAdapter.height(80),
            child: Row(
              children: [
                Text(
                  "运费:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenAdapter.fontSize(32)),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "免运费包邮",
                  style: TextStyle(fontSize: ScreenAdapter.fontSize(30)),
                )
              ],
            ),
          ),

          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
