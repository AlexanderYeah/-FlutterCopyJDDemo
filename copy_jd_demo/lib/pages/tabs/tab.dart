import 'dart:ui';

import 'package:flutter/material.dart';
import 'cart.dart';
import 'home.dart';
import 'user.dart';
import '../tabs/category.dart';
import '../../services/screenAdaper.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedIdx = 0;

  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _selectedIdx = 0;
    this._pageController = PageController(initialPage: this._selectedIdx);
  }

  List _pageList = [HomePage(), CategoryPage(), CartPage(), UserPage()];

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Container(
            padding: EdgeInsets.only(left: 15),
            height: ScreenAdapter.height(60),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.search),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "iPhone14 Pro Max",
                  style: TextStyle(fontSize: ScreenAdapter.fontSize(28)),
                )
              ],
            ),
          ),
          // 点击跳转搜索
          onTap: () {
            Navigator.of(context).pushNamed("/productSearch");
          },
        ),
        leading:
            IconButton(icon: Icon(Icons.center_focus_weak), onPressed: null),
        actions: <Widget>[
          IconButton(onPressed: null, icon: Icon(Icons.message))
        ],
      ),
      body: PageView(
        controller: this._pageController,
        children: [HomePage(), CategoryPage(), CartPage(), UserPage()],
        // 监听四个tab滚动的回调
        onPageChanged: (index) {
          setState(() {
            _selectedIdx = index;
          });
        },
        // 禁止四个tab滑动
        // physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.redAccent,
        currentIndex: _selectedIdx,
        // 切换按钮
        onTap: (idx) {
          setState(() {
            _selectedIdx = idx;
            this._pageController!.jumpToPage(idx);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "首页",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "分类",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "购物车",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "我的",
          ),
        ],
      ),
    );
  }
}
