import 'package:flutter/material.dart';
import '../services/screenAdaper.dart';

typedef JDProductButtonCallback = void Function();

class JDProductButton extends StatelessWidget {
  // 外部传递过来颜色 和 标题
  Color color;
  String text;
  JDProductButtonCallback? callback;

  JDProductButton(
      {super.key, this.color = Colors.black, this.text = "按钮", this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: callback!,
        child: Container(
          width: double.infinity,
          height: ScreenAdapter.height(70),
          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: this.color,
          ),
          child: Center(
              child: Text(this.text, style: TextStyle(color: Colors.white))),
        ));
  }
}
