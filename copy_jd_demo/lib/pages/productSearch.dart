import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/screenAdaper.dart';
import '../services/searchProductService.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({super.key});
  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  var _keywords;
  // 本地搜索历史的数据
  List _historyListData = [];
  // 热搜数据 模拟服务器
  List _hotSearchData = [
    "iPhone 14 Pro",
    "惠普打印机",
    "便携充电宝",
    "公牛插座",
    "碎纸机",
    "投影仪(公司专用)"
  ];

  @override
  void initState() {
    // TODO: implement initState
    _getHistoryData();
  }

  /*---------Data Handle------*/
  _getHistoryData() async {
    // await SearchServices.clearHistoryList();
    var _historyListData = await SearchServices.getHistoryList();
    // 这里一定要更新数据源
    setState(() {
      this._historyListData = _historyListData;
    });
  }

  /*---------UI------*/
  // 返回搜索记录的头部
  Widget _searchHistoryHeaderWidget() {
    // 当且仅当搜索历史数据不为空的时候 才会显示标题和删除历史记录
    if (this._historyListData.length != 0) {
      return Column(
        children: [
          Container(
            width: ScreenAdapter.getScreenWidth(),
            height: 33,
            child: Stack(children: [
              Positioned(
                left: 5,
                height: 30,
                child: Container(
                  child: Text("历史记录",
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ),
              Positioned(
                right: 8,
                height: 30,
                child: ElevatedButton(
                    child: Text(
                      "清空历史",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    onPressed: _showClearDialog),
              ),
            ]),
          ),
          Divider(),
        ],
      );
    } else {
      return Text("");
    }
  }

  Widget _searchHistoryWidget() {
    return Container(
      child: // 搜索记录
          Wrap(
              children: this._historyListData.map((element) {
        return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Text(element),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.9),
              borderRadius: BorderRadius.circular(15)),
        );
      }).toList()),
    );
  }

  /*---------Action------*/
  _showClearDialog() async {
    final alertOption = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "温馨提示",
              style: TextStyle(color: Colors.redAccent),
            ),
            content: Text("您确认清空所有的搜索历史记录吗？"),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("取消"),
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              ),
              ElevatedButton(
                onPressed: () async {
                  // 1  异步
                  await SearchServices.clearHistoryList();
                  // 2 获取历史记录
                  _getHistoryData();
                  // 3 退出
                  Navigator.of(context).pop();
                },
                child: Text("确认"),
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              ),
            ],
          );
        });
  }

  _clearHistoryAction() async {
    await SearchServices.clearHistoryList();
    // 重新加载数据
    _getHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: TextField(
              onChanged: (value) {
                this._keywords = value;
              },
              // 首次进来 收起键盘
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none)),
            ),
            height: ScreenAdapter.height(60),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(30)),
          ),
          actions: [
            InkWell(
              onTap: () {
                SearchServices.setHistoryData(this._keywords);
                // 搜索按钮的点击 模拟传递参数
                Navigator.of(context).pushReplacementNamed("/productList",
                    arguments: {"keywords": this._keywords});
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 15, 15, 0),
                height: ScreenAdapter.height(68),
                width: ScreenAdapter.width(80),
                child: Text(
                  "搜索",
                  style: TextStyle(color: Colors.black87, fontSize: 17),
                ),
              ),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                child: Text("热搜商品",
                    style: TextStyle(color: Colors.black, fontSize: 17)),
              ),
              Divider(),
              Wrap(
                children: this._hotSearchData.map((element) {
                  return InkWell(
                    onTap: () {
                      // 1 跳转
                      Navigator.of(context).pushReplacementNamed("/productList",
                          arguments: {"keywords": element});
                      // 保存记录
                      SearchServices.setHistoryData(element);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        element,
                        style: TextStyle(color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                }).toList(),
              ),
              _searchHistoryHeaderWidget(),
              // 搜索历史记录
              _searchHistoryWidget(),
            ],
          ),
        ));
  }
}
