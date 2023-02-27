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
  String _sort = "";
  //
  List _tabHeaderList = [
    {
      "id": 1,
      "title": "综合",
      "fileds": "all",
      "sort":
          -1, //排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    },
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    // {"id": 4, "title": "筛选"}
  ];

  int _selectedTabIndex = 1;

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
        // 这里进行一个copy 操作，因为排序直接回改变原来list的数据结构
        List resultList = [];
        resultList.addAll(tempList);
        // 看是否有排序操作
        switch (this._sort) {
          case "salecount_1":
            // 销量升序
            resultList.sort((left, right) =>
                left["salecount"].compareTo(right["salecount"]));
            break;
          case "salecount_-1":
            // 销量降序
            resultList.sort((left, right) =>
                right["salecount"].compareTo(left["salecount"]));
            break;
          case "price_1":
            // 价格升序
            resultList
                .sort((left, right) => left["price"].compareTo(right["price"]));
            break;
          case "price_-1":
            // 价格降序
            resultList
                .sort((left, right) => right["price"].compareTo(left["price"]));
            break;
          default:
        }

        _productList.clear();
        for (var i = 0; i < resultList.length; i++) {
          Map<String, dynamic> element = resultList[i];
          if (i < _page * 2000) {
            _productList.add(ProductItemmModel.fromJson(element));
          }
        }
        print(_productList.first.title);
        // 如果没有数据 就不用请求数据了
        if (resultList.length < _page * 10) {
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

  Widget _showTabHeaderArrowIcon(index) {
    // 只有销量和价格才有箭头
    if (index == 2 || index == 3) {
      if (this._tabHeaderList[index - 1]["sort"] == 1) {
        return Icon(Icons.arrow_drop_down);
      }
      return Icon(Icons.arrow_drop_up);
    }
    return Text("");
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
              children: this._tabHeaderList.map((value) {
            // 这个地方动态循环遍历去创建顶部的导航栏按钮
            return Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      //点击改变索引值
                      _tabHeaderChange(value["id"]);
                    });
                  },
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(10),
                          0, ScreenAdapter.height(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${value['title']}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: this._selectedTabIndex == value["id"]
                                    ? Colors.red
                                    : Colors.black,
                                fontSize: 17),
                          ),
                          _showTabHeaderArrowIcon(value['id']),
                        ],
                      )),
                ));
          }).toList()),
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

  /**-----点击事件方法-------*/
  _tabHeaderChange(index) {
    if (index == 4) {
      // 点击了筛选 打开侧边栏
      _scaffoldkey.currentState!.openEndDrawer();
      setState(() {
        this._selectedTabIndex = index;
      });
    } else {
      setState(() {
        //1  重置分页
        _page = 1;
        _haveMore = true;
        //2 清空数据
        _productList.clear();
        //3 设置排序
        // 这里记住置反操作 升序与降序,反复点击就没问题了
        this._tabHeaderList[index - 1]["sort"] =
            this._tabHeaderList[index - 1]["sort"] * -1;
        _sort =
            "${this._tabHeaderList[index - 1]["fileds"]}_${this._tabHeaderList[index - 1]["sort"]}";

        //4 滚动到顶部
        // _scrollController.jumpTo(0);
        print(this._sort);
        _getProductListData();
        this._selectedTabIndex = index;
      });
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
