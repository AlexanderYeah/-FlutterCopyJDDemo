import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../services/screenAdaper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //

  List _bannerList = [
    {"path": "images/HomeBanner/banner_2.jpeg"},
    {"path": "images/HomeBanner/banner_3.jpeg"},
    {"path": "images/HomeBanner/banner_4.jpeg"},
  ];

  //

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

  // 推荐商品的数据
  _recommendProductItemWidget() {
    var itemWidth = (ScreenAdapter.getScreenWidth() - 20 - 10) / 2;
    return Container(
        width: itemWidth,
        padding: EdgeInsets.all(10),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black12, width: 1)),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                // 避免服务器返回的图片比例不一致
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                      "https://www.itying.com/images/flutter/list1.jpg"),
                )),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "2023款LV大衣给你不一样的体验,奥利给,2023款LV大衣给你不一样的体验",
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
                      "¥198",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "¥999",
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
  }

  // 热门商品

  Widget _hotProductList() {
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
                  "https://www.itying.com/images/flutter/hot${index + 1}.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: 44,
                padding: EdgeInsets.only(top: ScreenAdapter.width(10)),
                child: Text("第{$index}条数据"),
              ),
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }

  // 轮播图
  Widget _swiperWidget() {
    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              _bannerList[index]["path"],
              fit: BoxFit.fill,
            );
          },
          autoplay: true,
          itemCount: 3,
          // 分页器
          pagination: SwiperPagination(),
          // control: SwiperControl(),
        ),
      ),
    );
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
        _titleWidget("猜你喜欢"),
        SizedBox(height: ScreenAdapter.height(15)),
        _hotProductList(),
        _titleWidget("热门推荐"),
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: [
              _recommendProductItemWidget(),
              _recommendProductItemWidget(),
              _recommendProductItemWidget(),
              _recommendProductItemWidget(),
              _recommendProductItemWidget(),
              _recommendProductItemWidget(),
            ],
          ),
        )
      ],
    );
  }
}
