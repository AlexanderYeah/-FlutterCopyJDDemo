import 'package:flutter/material.dart';
import './productDetail/ProductDetailComment.dart';
import './productDetail/ProductDetailInfoPage.dart';
import './productDetail/productDetailGoods.dart';
import '../services/screenAdaper.dart';
import '.././widget/jdProductButton.dart';
import '../model/productDetailModel.dart';
import '../localData/productDetailData.dart';
import '../widget/loadingWidget.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  /*****---Life Cycle-----***/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProductData();
  }
  /*****---DataHandle-----***/

  ProductDetailModel _model = ProductDetailModel();

  _getProductData() {
    _model = ProductDetailModel.fromJson(productDetailData);
    setState(() {
      // 更新数据
    });
  }

  Widget _bodyWidget() {
    if (this._model.title != null) {
      return Stack(
        children: [
          TabBarView(children: <Widget>[
            ProductDetailGoodsPage(model: this._model),
            ProductDetailInfoPage(),
            ProductDetailCommentPage(),
          ]),
          Positioned(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(90),
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Color.fromRGBO(233, 233, 233, 1)))),
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      // 第一个购物车按钮
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        width: ScreenAdapter.width(200),
                        height: ScreenAdapter.height(88),
                        child: Column(
                          children: [Icon(Icons.shopping_cart), Text("购物车")],
                        ),
                      ),
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
                ),
              ))
        ],
      );
    } else {
      return LoadingWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            // 放在容器内部 设定宽度 这样显得居中紧凑很多
            title: Container(
              width: ScreenAdapter.width(400),
              child: TabBar(
                tabs: [
                  Tab(
                    child: Text("商品", style: TextStyle(color: Colors.black)),
                  ),
                  Tab(
                    child: Text("详情", style: TextStyle(color: Colors.black)),
                  ),
                  Tab(
                    child: Text("评价", style: TextStyle(color: Colors.black)),
                  )
                ],
                indicatorColor: Colors.redAccent,
                indicatorSize: TabBarIndicatorSize.label,
              ),
            ),
            // 右上方的按钮
            actions: [
              // IconButton(
              //     onPressed: () {

              //     },
              //     icon: Icon(Icons.more_horiz))
            ],
          ),
          body: _bodyWidget(),
        ));
  }
}
