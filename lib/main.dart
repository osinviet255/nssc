import 'package:flutter/material.dart';
import 'package:nssc/shared/notificationView.dart';
import 'package:nssc/design/homePage.dart';
void main() {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: MyNotification()
    );
  }
}












