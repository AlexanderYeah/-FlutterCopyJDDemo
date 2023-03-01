import 'package:copy_jd_demo/localData/productDetailData.dart';
import 'package:flutter/material.dart';
import '../../model/productDetailModel.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ProductDetailInfoPage extends StatefulWidget {
  var model;
  ProductDetailInfoPage({super.key, this.model});

  @override
  State<ProductDetailInfoPage> createState() => _ProductDetailInfoPageState();
}

class _ProductDetailInfoPageState extends State<ProductDetailInfoPage>
    with AutomaticKeepAliveClientMixin {
  // 下面是避免切换到详情的时候 又去重新加载html  做了一个缓存
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  ProductDetailModel _detailModel = ProductDetailModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _detailModel = widget.model;
    print(_detailModel.detainInfoUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Expanded(
            child: InAppWebView(
          initialUrlRequest:
              URLRequest(url: Uri.parse(this._detailModel.detainInfoUrl!)),
          // pullToRefreshController: pullToRefreshController,
        ))
      ],
    ));
  }
}
