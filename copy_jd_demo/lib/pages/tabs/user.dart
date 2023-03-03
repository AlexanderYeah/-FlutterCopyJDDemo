import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
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
      body: Text("User"),
    );
  }
}
