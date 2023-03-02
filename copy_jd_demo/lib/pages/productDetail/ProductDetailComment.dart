import 'package:flutter/material.dart';
import '../../localData/productCommentData.dart';

class ProductDetailCommentPage extends StatefulWidget {
  const ProductDetailCommentPage({super.key});

  @override
  State<ProductDetailCommentPage> createState() =>
      _ProductDetailCommentPageState();
}

class _ProductDetailCommentPageState extends State<ProductDetailCommentPage>
    with AutomaticKeepAliveClientMixin {
  List _commentData = [];
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentData = productCommentData;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this._commentData.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.fromLTRB(16, 16, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 上半部分内容
                Row(
                  children: [
                    Image.network(
                      "${this._commentData[index]["headerImg"]}",
                      fit: BoxFit.fill,
                      width: 35,
                      height: 35,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${this._commentData[index]["userName"]}",
                      style: TextStyle(color: Colors.black54, fontSize: 18),
                    )
                  ],
                ),
                // 下半部分文字内容

                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    "${this._commentData[index]["content"]}",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                ),
                Divider(
                  height: 20,
                )
              ],
            ),
          );
        });
  }
}
