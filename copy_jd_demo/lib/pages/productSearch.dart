import 'package:flutter/material.dart';
import '../services/screenAdaper.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({super.key});
  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  var _keywords;

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
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Divider(),
              Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Text("充电宝"),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ],
              ),
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
                        onPressed: null),
                  ),
                ]),
              ),

              // 搜索记录
              Divider(height: 1),
              Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Text("充电宝"),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
