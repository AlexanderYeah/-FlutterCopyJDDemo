import 'package:flutter/material.dart';
import './productDetail/ProductDetailComment.dart';
import './productDetail/ProductDetailInfoPage.dart';
import './productDetail/productDetailGoods.dart';
import '../services/screenAdaper.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
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
              IconButton(onPressed: null, icon: Icon(Icons.more_horiz))
            ],
          ),
          body: TabBarView(children: <Widget>[
            ProductDetailGoodsPage(),
            ProductDetailInfoPage(),
            ProductDetailCommentPage(),
          ]),
        ));
  }
}
