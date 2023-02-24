import 'package:flutter/material.dart';
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
      height: ScreenAdapter.height(30),
      width: ScreenAdapter.width(50),
      margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
      padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.red,
        width: 6,
      ))),
      child: Text(title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54)),
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
        _titleWidget("You May Like"),
        SizedBox(height: ScreenAdapter.height(15)),
        _titleWidget("You May Like"),
      ],
    );
  }
}
