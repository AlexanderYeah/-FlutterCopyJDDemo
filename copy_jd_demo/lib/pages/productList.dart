import 'dart:io';

import 'package:copy_jd_demo/model/productListModel.dart';
import 'package:copy_jd_demo/widget/loadingWidget.dart';
import 'package:flutter/material.dart';
import '../services/screenAdaper.dart';
import '../localData/productListData.dart';

class ProductListPage extends StatefulWidget {
  Map arguments;
  ProductListPage({Key? key, required this.arguments}) : super(key: key);
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override

  // 定义一个全局的key
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  // 分页
  int _page = 1;
  // 数据
  List _productList = [];
  // 排序
  String sort = "";
  //
  ScrollController _scrollController = ScrollController();
  // 请求开关 当本次请求回来之前 不进行下次请求
  bool _requestFlag = true;
  // 是否有更多的数据
  bool _haveMore = true;
  /**------Life Cycle---------*/
  @override
  void initState() {
    super.initState();
    _getProductListData();
    // 监听scrollController 的滚动事件
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        _page++;
        print("滑动到了底部${_page}");
        // 可以请求的时候 再去请求
        if (_requestFlag && _haveMore) {
          _getProductListData();
        }
      }
    });
  }

  /**------Data---------*/
  _getProductListData() {
    setState(() {
      _requestFlag = false;
    });
    productListData.forEach((key, value) {
      if (key == "phone") {
        List tempList = productListData[key];

        _productList.clear();
        for (var i = 0; i < tempList.length; i++) {
          Map<String, dynamic> element = tempList[i];
          if (i < _page * 10) {
            _productList.add(ProductItemmModel.fromJson(element));
          }
        }
        // 如果没有数据 就不用请求数据了
        if (tempList.length < _page * 10) {
          _haveMore = false;
        } else {
          _haveMore = true;
        }
      }
    });
    setState(() {
      _requestFlag = true;
    });
  }

  /**------UI---------*/
  // 商品列表
  Widget listWidget() {
    if (_productList.length > 0) {
      return Container(
        margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: ScreenAdapter.width(180),
                      height: ScreenAdapter.width(180),
                      child: Image.network(
                        _productList[index].pic,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: ScreenAdapter.width(180),
                          margin: EdgeInsets.only(left: 10),
                          // color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _productList[index].title,
                                maxLines: 2,
                                style: TextStyle(color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "惊爆价:¥ ${_productList[index].price}",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
                // 分割线
                Divider(
                  height: 20,
                ),
                // 返回一个加载更多的提示
                _showMore(index),
              ],
            );
          },
          controller: _scrollController,
          itemCount: _productList.length,
        ),
      );
    } else {
      return LoadingWidget();
    }
  }

  // 筛选浮动导航
  Widget tabHeaderWidget() {
    return Positioned(
        top: 0,
        width: ScreenAdapter.width(750),
        height: ScreenAdapter.height(80),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromRGBO(233, 233, 233, 1)))),
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(80),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(10),
                          0, ScreenAdapter.height(10)),
                      child: Text(
                        "综合",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(10),
                          0, ScreenAdapter.height(10)),
                      child: Text(
                        "筛选",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            0,
                            ScreenAdapter.height(10),
                            0,
                            ScreenAdapter.height(10)),
                        child: Text(
                          "价格",
                          textAlign: TextAlign.center,
                        ),
                      ))),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        _scaffoldkey.currentState!.openEndDrawer();
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            0,
                            ScreenAdapter.height(10),
                            0,
                            ScreenAdapter.height(10)),
                        child: Text(
                          "筛选",
                          textAlign: TextAlign.center,
                        ),
                      )))
            ],
          ),
        ));
  }

  // 加载更多Widget
  Widget _showMore(int index) {
    if (_haveMore) {
      return (index == this._productList.length - 1)
          ? LoadingWidget()
          : Text("");
    } else {
      return (index == this._productList.length - 1)
          ? Text("--------我是有底线的-------")
          : Text("");
    }
  }

  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("商品列表"),
          // 把text 置为空,是为了去掉右上方打开抽屉的的菜单栏
          actions: [
            Text(""),
          ],
        ),
        endDrawer: Drawer(
          child: Container(
            child: Text("data"),
          ),
        ),
        key: _scaffoldkey,
        body: Stack(
          children: <Widget>[
            // 列表
            listWidget(),
            // 上方的tab 栏 定位到上方去
            tabHeaderWidget(),
          ],
        ));
  }
}
