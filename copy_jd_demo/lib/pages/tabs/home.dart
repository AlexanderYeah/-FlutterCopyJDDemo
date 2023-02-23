import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 轮播图
  Widget _swiperWidget() {
    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              "https://img2.baidu.com/it/u=582675930,4171146327&fm=253&fmt=auto?w=750&h=500",
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
    return ListView(
      children: [
        _swiperWidget(),
      ],
    );
  }
}
