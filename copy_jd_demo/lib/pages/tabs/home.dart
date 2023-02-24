import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
// 适配的库
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      height: ScreenUtil().setHeight(30),
      width: ScreenUtil().setWidth(50),
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
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
    ScreenUtil.init(context, designSize: const Size(750, 1334));
    return ListView(
      children: [
        _swiperWidget(),
        SizedBox(
          height: 15,
        ),
        _titleWidget("You May Like"),
        SizedBox(height: 15),
        _titleWidget("You May Like"),
      ],
    );
  }
}
