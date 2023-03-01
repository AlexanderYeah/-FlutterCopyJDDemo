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
  /*****---DataHandle-----***/
  @override
  void initState() {
    super.initState();
    _detailModel = widget.model;
    print(_detailModel.title);
  }

  List<Widget> _categoryWidget() {
    List<Widget> tempList = [];

    this._detailModel.arrtributes!.forEach((element) {
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
              Container(
                width: ScreenAdapter.width(586),
                child: Wrap(
                    children: element.list!.map((value) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    child: Chip(
                      label: Text(
                        "${value}",
                        style: TextStyle(fontSize: ScreenAdapter.fontSize(32)),
                      ),
                      padding: EdgeInsets.all(5),
                    ),
                  );
                }).toList()),
              )
            ],
          )
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
                      children: _categoryWidget(),
                    ),
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
                                  },
                                )),
                            Expanded(
                                flex: 1,
                                child: JDProductButton(
                                  color: Color.fromRGBO(255, 165, 0, 0.9),
                                  text: "立即购买",
                                  callback: () {
                                    print("立即购买");
                                  },
                                ))
                          ],
                        ),
                      ))
                ],
              ));
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
                    "115, 黑色, XL, 1件 ",
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
