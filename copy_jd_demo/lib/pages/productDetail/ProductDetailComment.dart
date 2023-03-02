import 'package:copy_jd_demo/services/screenAdaper.dart';
import 'package:flutter/material.dart';
import '../../localData/productCommentData.dart';
import '../../services/screenAdaper.dart';

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

  List<Widget> _picListData(element) {
    List<Widget> tempList = [];
    tempList.add(Image.network(element[0], fit: BoxFit.cover));

    return tempList;
  }

  Widget _commentPicsWidget(element) {
    int totalCount = element.length;
    double itemW = (ScreenAdapter.width(750) - 50) / 3;
    double height = totalCount * 130;
    if (element.length != 0) {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
        width: itemW,
        child: Wrap(
          children: element.length != 0 ? _picListData(element) : [Text("")],
        ),
      );
    } else {
      return Text("");
    }
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
                // 返回图片
                _commentPicsWidget(this._commentData[index]["imgs"]),
                Divider(
                  height: 20,
                )
              ],
            ),
          );
        });
  }
}
