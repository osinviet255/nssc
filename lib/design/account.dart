import 'package:flutter/material.dart';
import 'package:nssc/shared/notificationView.dart';

import 'contactPage.dart';

class account extends StatefulWidget {
  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<account> {
  @override
  void initState() {
    super.initState();
    new MyNotification();
  }
  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));    }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.white,
          title: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: Text("Tài khoản", style: new TextStyle(color: Colors.blue, fontWeight: FontWeight.normal),),
              )
          )
      ),
      body: Container(
        width: deviceWidth,
        color: Colors.white,
        margin: EdgeInsets.only(top: 10),
        child: ListView(
          children: <Widget>[
            GestureDetector(
            onTap: (){

      },
        child: Container(
            height: 60,
            width: deviceWidth,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
            ),
            child: Container(
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _colorFromHex("#cccccc"), width: 1),
                  boxShadow: [BoxShadow(color: Colors.white)]
              ),
              padding: EdgeInsets.all(1.5),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact()))
                    },
                    child: Container(
                      width: deviceWidth * 0.5,
                      padding: EdgeInsets.all(17),
                      height: 60,
                      child: Text("Đăng dự án mới", style: new TextStyle(fontSize: 16),),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      width: deviceWidth * 0.5,
                      height: 60,
                      padding: EdgeInsets.only(left: 15, right: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(">", style: new TextStyle(fontSize: 22)),
                      )
                    ),
                  )
                ],
              ),
            )
        ),
      ),
            GestureDetector(
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact()))
              },
              child: Container(
                  height: 60,
                  width: deviceWidth,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _colorFromHex("#cccccc"), width: 1),
                        boxShadow: [BoxShadow(color: Colors.white)]
                    ),
                    padding: EdgeInsets.all(1.5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: deviceWidth * 0.5,
                          padding: EdgeInsets.all(17),
                          height: 60,
                          child: Text("Quản lý dự án đã đăng", style: new TextStyle(fontSize: 16),),
                        ),
                        Expanded(
                          child: Container(
                              width: deviceWidth * 0.5,
                              height: 60,
                              padding: EdgeInsets.only(left: 15, right: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(">", style: new TextStyle(fontSize: 22)),
                              )
                          ),
                        )
                      ],
                    ),
                  ),
              ),
            ),
            GestureDetector(
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact()))
              },
              child: Container(
                  height: 60,
                  width: deviceWidth,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _colorFromHex("#cccccc"), width: 1),
                        boxShadow: [BoxShadow(color: Colors.white)]
                    ),
                    padding: EdgeInsets.all(1.5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: deviceWidth * 0.5,
                          padding: EdgeInsets.all(17),
                          height: 60,
                          child: Text("Tiện ích", style: new TextStyle(fontSize: 16),),
                        ),
                        Expanded(
                          child: Container(
                              width: deviceWidth * 0.5,
                              height: 60,
                              padding: EdgeInsets.only(left: 15, right: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(">", style: new TextStyle(fontSize: 22)),
                              )
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ),
            GestureDetector(
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact()))
              },
              child: Container(
                  height: 60,
                  width: deviceWidth,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _colorFromHex("#cccccc"), width: 1),
                        boxShadow: [BoxShadow(color: Colors.white)]
                    ),
                    padding: EdgeInsets.all(1.5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: deviceWidth * 0.5,
                          padding: EdgeInsets.all(17),
                          height: 60,
                          child: Text("Liên hệ", style: new TextStyle(fontSize: 16),),
                        ),
                        Expanded(
                          child: Container(
                              width: deviceWidth * 0.5,
                              height: 60,
                              padding: EdgeInsets.only(left: 15, right: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(">", style: new TextStyle(fontSize: 22)),
                              )
                          ),
                        )
                      ],
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}

