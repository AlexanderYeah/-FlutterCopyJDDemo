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
        _titleWidget("你可能喜欢"),
        SizedBox(height: ScreenAdapter.height(15)),
        _hotProductList(),
        _titleWidget("你可能喜欢"),
      ],
    );
  }
}
