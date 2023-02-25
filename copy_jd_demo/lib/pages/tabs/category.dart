import 'package:copy_jd_demo/services/screenAdaper.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectedIdx = 0;

  // 屏幕设备的适配
  static double leftWidth = ScreenAdapter.getScreenWidth() / 4;
  // 右侧每一项的宽度 = 屏幕宽度 - GridView 外侧原生左右的Padding值 - GridView Item 中间的间距
  // 在flutter 中你不能创建一个变量 依赖另一个变量
  static double rightItemWidth =
      (ScreenAdapter.getScreenWidth() - leftWidth - 20 - 20) / 3;
  var rightItemHeight = rightItemWidth + ScreenAdapter.height(28);

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Row(children: [
      // 左侧的宽度是固定的
      Container(
        width: leftWidth,
        height: double.infinity,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    // 点击选中的索引值
                    setState(() {
                      _selectedIdx = index;
                    });
                  },
                  child: Container(
                    color: _selectedIdx == index ? Colors.red : Colors.white,
                    width: double.infinity,
                    height: 46,
                    child: Text(
                      "分类",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Divider(height: 1)
              ],
            );
          },
          itemCount: 80,
        ),
      ),
      // 右侧的宽度是浮动的
      Expanded(
        child: Container(
            padding: EdgeInsets.all(10),
            height: double.infinity,
            color: Color.fromARGB(1, 240, 246, 246),
            child: GridView.builder(
                // 代理方法
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: rightItemWidth / rightItemHeight,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                // 数量
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    child: Container(
                      child: Column(
                        children: [
                          AspectRatio(
                              aspectRatio: 1 / 1,
                              child: Image.network(
                                  "http://s1.inewhope.com/images/202202/goods_img/71686_G_1645811501552.png")),
                          Container(
                            height: ScreenAdapter.height(28),
                            child: Text("大佬便装"),
                          )
                        ],
                      ),
                    ),
                  );
                })),
      )
    ]);
  }
}
