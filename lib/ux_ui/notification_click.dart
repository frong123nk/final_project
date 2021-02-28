import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_final_v2/model/medicine.dart';

class NotificationClick extends StatelessWidget {
  String paylod;
  // NotificationClick();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("ffa45b"), //แถบด้านบน
        elevation: 0.0,
      ),
      body: Container(
        color: Color(0xFFF6F8FC),
        child: Column(
          children: <Widget>[
            Text("aaaaaaaaaaaaa")
            // Flexible(
            //   flex: 3,
            //   child: TopContainer(), //TopContainer()
            // ),
          ],
        ),
      ),
    );
  }
}
