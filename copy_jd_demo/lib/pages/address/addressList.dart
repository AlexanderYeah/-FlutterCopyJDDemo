import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../../widget/jdProductButton.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({super.key});

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  @override
  Widget _addressListItem() {
    return Column(
      children: [
        Container(
          height: ScreenAdapter.height(120),
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Icon(
              Icons.check_circle,
              color: Colors.redAccent,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("大风吹"),
                SizedBox(
                  height: 2,
                ),
                Text("无所谓发"),
              ],
            ),
            trailing: Icon(Icons.navigate_next),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "收货地址",
            style: TextStyle(color: Colors.black87),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Color.fromRGBO(238, 238, 238, 1),
        child: Stack(
          children: [
            // 地址
            ListView(
              children: [
                _addressListItem(),
                _addressListItem(),
                _addressListItem(),
              ],
            ),
            // 添加地址按钮
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: ScreenAdapter.width(710),
                  height: ScreenAdapter.height(70),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/addressAdd");
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.redAccent)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          Text(
                            "添加地址",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenAdapter.fontSize(30)),
                          ),
                        ],
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
