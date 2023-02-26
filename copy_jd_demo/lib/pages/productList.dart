import 'package:flutter/material.dart';
import '../services/screenAdaper.dart';

class ProductListPage extends StatefulWidget {
  Map arguments;
  ProductListPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("商品列表"),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: ScreenAdapter.width(180),
                      height: ScreenAdapter.width(180),
                      child: Image.network(
                        "http://s1.inewhope.com/images/202209/goods_img/90336_P_1662077713828.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: ScreenAdapter.width(180),
                          margin: EdgeInsets.only(left: 10),
                          // color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "data",
                                maxLines: 2,
                                style: TextStyle(color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "22222",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
                // 分割线
                Divider(
                  height: 20,
                )
              ],
            );
          },
          itemCount: 10,
        ));
  }
}
