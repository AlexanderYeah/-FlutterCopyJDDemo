import 'package:flutter/material.dart';
import '../services/screenAdaper.dart';

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

  /**------UI---------*/
  // 商品列表
  Widget listWidget() {
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
                      "http://s1.inewhope.com/images/202209/goods_img/90336_P_1662077713828.png",
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
                              "data",
                              maxLines: 2,
                              style: TextStyle(color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "22222",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            )
                          ],
                        ),
                      ))
                ],
              ),
              // 分割线
              Divider(
                height: 20,
              )
            ],
          );
        },
        itemCount: 10,
      ),
    );
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
