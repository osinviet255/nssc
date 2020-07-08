import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter_html/style.dart';
import 'package:nssc/model/NotificationData.dart';
import 'package:nssc/shared/notificationView.dart';
import 'package:flutter_html/flutter_html.dart';

class MyNotificationList extends StatefulWidget {
  List<NotificationData> list;
  MyNotificationList({@required this.list});
  @override
  _MyNotificationListState createState() => _MyNotificationListState(list);
}
class _MyNotificationListState extends State<MyNotificationList> {
  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));    }
  List<NotificationData> list;
  _MyNotificationListState(this.list);
  @override
  void initState() {
    super.initState();
    setState(() {
      return new MyNotification();
    });
  }
  @override
  Widget build(BuildContext context) {
    if(list == null || list.length == 0)
      return Scaffold(
        appBar: new AppBar(
            backgroundColor: Colors.white,
            title: Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Text("Thông báo", style: new TextStyle(color: Colors.blue, fontWeight: FontWeight.normal),),
                )
            )
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Image.asset('assets/notif.png'),
          ),
        ),
      );
    else
      return Scaffold(
        appBar: new AppBar(
            backgroundColor: Colors.white,
            title: Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Text("Thông báo", style: new TextStyle(color: Colors.blue, fontWeight: FontWeight.normal),),
                )
            )
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: ListView.builder(
              itemCount: list == null ? 0 : list.length,
              itemBuilder: (context, index){
                return _buildRow(list.reversed.toList()[index]);
              },
            ),
          ),
        ),
      );
  }

  Widget _buildRow(NotificationData notification){
    double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        //_makeHttpPostValue(news["ID"].toString());
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailNews(newsId: int.parse(news["ID"].toString()),)));
      },
      child: FittedBox(
        fit: BoxFit.fill,
        child: Container(
//            height: 140,
            width: deviceWidth,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _colorFromHex("#cccccc"), width: 1),
                  boxShadow: [BoxShadow(color: Colors.white)]
              ),
              padding: EdgeInsets.all(1.5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Container(
                      width: deviceWidth * 0.9,
                      padding: EdgeInsets.only(top: 17, left: 17),
                      //height: 160,
                      child: Text(notification.khoangcach, style: new TextStyle(fontSize: 13, color: Colors.blue),),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Container(
                      width: deviceWidth * 0.9,
                      padding: EdgeInsets.only(left: 17, right: 17, bottom: 17, top: 5),
                      //height: 160,
                      child: Text(notification.title, style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Container(
                        width: deviceWidth * 0.9,
                        //height: 160,
                        padding: EdgeInsets.only(left: 15, right: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(notification.body, style: new TextStyle(fontSize: 16),)
                        )
                    ),
                  )
                ],
              ),
            )
        ),
      )
    );
  }
}


//class MyNotificationList extends StatelessWidget {
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: new AppBar(
//        backgroundColor: Colors.white,
//        title: Align(
//          alignment: Alignment.center,
//          child: Container(
//            decoration: BoxDecoration(
//              color: Colors.white
//            ),
//            child: Text("Thông báo", style: new TextStyle(color: Colors.blue, fontWeight: FontWeight.normal),),
//          )
//        )
//      ),
//      body: Container(
//        color: Colors.white,
//        child: Center(
//          child: Image.asset('assets/notif.png'),
//        ),
//      ),
//    );
//  }
//}
