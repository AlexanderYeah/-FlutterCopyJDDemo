import 'package:flutter/material.dart';
import '../services/screenAdaper.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({super.key});

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
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
              // 搜索按钮的点击
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
      body: Text("data"),
    );
  }
}
