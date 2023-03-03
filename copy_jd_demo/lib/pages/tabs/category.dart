import 'package:copy_jd_demo/services/screenAdaper.dart';
import 'package:flutter/material.dart';
import '../../localData/categoryData.dart';
import '../../model/categoryItemModel.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  int _selectedIdx = 0;
  // 左边选中标题的list
  List _leftTitleList = [];
  List _rightItemList = [];

  // 屏幕设备的适配
  static double leftWidth = ScreenAdapter.getScreenWidth() / 4;
  // 右侧每一项的宽度 = 屏幕宽度 - GridView 外侧原生左右的Padding值 - GridView Item 中间的间距
  // 在flutter 中你不能创建一个变量 依赖另一个变量
  static double rightItemWidth =
      (ScreenAdapter.getScreenWidth() - leftWidth - 20 - 20) / 3;
  var rightItemHeight = rightItemWidth + ScreenAdapter.height(28);

  // 左侧的widget
  Widget _leftItemWidget() {
    // 即使左边的数组为空，也要返回一个宽度固定的容器，避免界面错位
    if (_leftTitleList.length > 0) {
      return Container(
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
                      _updateRightItemData(index);
                    });
                  },
                  child: Container(
                    color: _selectedIdx == index
                        ? Color.fromRGBO(240, 246, 246, 1)
                        : Colors.white,
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      _leftTitleList[index],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Divider(height: 1)
              ],
            );
          },
          itemCount: _leftTitleList.length,
        ),
      );
    } else {
      return Container(width: leftWidth, height: double.infinity);
    }
  }

  // 右边的Widget
  Widget _rightItemWidget() {
    if (_rightItemList.length > 0) {
      return Expanded(
        child: Container(
            padding: EdgeInsets.all(10),
            height: double.infinity,
            color: Color.fromRGBO(240, 246, 246, 1),
            child: GridView.builder(
                // 代理方法
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: rightItemWidth / rightItemHeight,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                // 数量
                itemCount: _rightItemList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    // 跳转分类界面
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed("/productList", arguments: {"aaa": "bbb"});
                    },
                    child: Container(
                      color: Colors.white,
                      child: Container(
                        child: Column(
                          children: [
                            AspectRatio(
                                aspectRatio: 1 / 1,
                                child:
                                    Image.network(_rightItemList[index].pic)),
                            Container(
                              height: ScreenAdapter.height(28),
                              child: Text(_rightItemList[index].title),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })),
      );
    } else {
      return Container(padding: EdgeInsets.all(10), height: double.infinity);
    }
  }

  // 获取左边分类的数据
  _getCategoryData() {
    setState(() {
      categoryData.forEach((key, value) {
        _leftTitleList.add(key);
      });
      _updateRightItemData(_selectedIdx);
    });
  }

  /**--------------Data Handle-----------------*/

  // 根据左边的索引 更新右边的值
  _updateRightItemData(int index) {
    String selectedTitle = _leftTitleList[index];

    List tempList = categoryData[selectedTitle];

    _rightItemList.clear();
    tempList.forEach((value) {
      _rightItemList.add(CategoryItemModel.fromJson(value));
    });
  }

  /**------------LifeCycle------------**/
  @override
  void initState() {
    // TODO: implement initState
    _getCategoryData();
  }

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
      body: Row(children: [
        // 左侧的宽度是固定的
        _leftItemWidget(),
        // 右侧的宽度是浮动的
        _rightItemWidget()
      ]),
    );
  }
}
