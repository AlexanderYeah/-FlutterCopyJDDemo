import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../services/screenAdaper.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:async';
import '../../model/homeBannerModel.dart';
import '../../config/config.dart';
import '../../model/productListModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  //
  List _bannerList = <Banners>[];
  // 淘货精选的数据
  List _taoHuoSelectList = <ProductItemmModel>[];
  // 推荐列表的数据
  List _recommendList = <ProductItemmModel>[];

  Widget _titleWidget(String title) {
    return Container(
      height: ScreenAdapter.height(40),
      width: ScreenAdapter.width(50),
      margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
      padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.red,
        width: 5,
      ))),
      child: Text(title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black54)),
    );
  }

  // 获取轮播图数据
  _getBannerData() async {
    var api = "${Config.domain}/getHomeBanners";
    final response = await Dio().get(api);
    HomeBannerModel model =
        HomeBannerModel.fromJson(json.decode(response.data));
    setState(() {
      if (model.banners != null) {
        _bannerList = model.banners!;
      }
    });
  }

  // 获取淘货精选数据
  _getTaoHuoSelectData() async {
    var api = "${Config.domain}/taoHuoSelectList";
    final response = await Dio().get(api);
    ProductListModel model =
        ProductListModel.fromJson(json.decode(response.data));
    setState(() {
      if (model.result != null) {
        _taoHuoSelectList = model.result!;
      }
    });
  }

  // 获取热门推荐的数据
  _getHotRommendData() async {
    var api = "${Config.domain}/homeRecommendProductList";
    final response = await Dio().get(api);
    ProductListModel model =
        ProductListModel.fromJson(json.decode(response.data));

    setState(() {
      if (model.result != null) {
        _recommendList = model.result!;
      }
    });
  }

  // 推荐商品的数据
  Widget recommendProductItem() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: _recommendList.map((element) {
            if (_taoHuoSelectList.length > 0) {
              var itemWidth = (ScreenAdapter.getScreenWidth() - 20 - 10) / 2;
              return Container(
                  width: itemWidth,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1)),
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          // 避免服务器返回的图片比例不一致
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.network(element.pic),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          element.title,
                          maxLines: 2,
                          // 溢出文字 ... 显示
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "¥${element.price}",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "¥${element.oldPrice}",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ));
            } else {
              return Text("加载中");
            }
          }).toList()),
    );
  }

  // 淘货精选
  Widget _hotProductList() {
    if (_taoHuoSelectList.length != 0) {
      return Container(
        height: ScreenAdapter.height(234),
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Container(
                  height: ScreenAdapter.width(140),
                  width: ScreenAdapter.width(140),
                  margin: EdgeInsets.only(right: ScreenAdapter.width(21)),
                  child: Image.network(
                    _taoHuoSelectList[index].pic,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: 44,
                  width: ScreenAdapter.width(140),
                  padding: EdgeInsets.only(top: ScreenAdapter.width(10)),
                  child: Text(
                    "¥${_taoHuoSelectList[index].price}",
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          },
          itemCount: _taoHuoSelectList.length,
        ),
      );
    } else {
      return Text("淘货精选");
    }
  }

  // 轮播图
  Widget _swiperWidget() {
    if (_bannerList.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                _bannerList[index].pic,
                fit: BoxFit.fill,
              );
            },
            autoplay: true,
            itemCount: _bannerList.length,
            // 分页器
            pagination: SwiperPagination(),
            // control: SwiperControl(),
          ),
        ),
      );
    } else {
      return Text("暂无数据");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBannerData();
    _getTaoHuoSelectData();
    _getHotRommendData();
  }

  @override
  // 首先能够上下滑动,则最外层需要包裹一个ListView
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return ListView(
      children: [
        _swiperWidget(),
        SizedBox(
          height: ScreenAdapter.height(15),
        ),
        _titleWidget("淘货精选"),
        SizedBox(height: ScreenAdapter.height(15)),
        _hotProductList(),
        _titleWidget("热门推荐"),
        recommendProductItem(),
      ],
    );
  }
}
