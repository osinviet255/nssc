import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nssc/design/home.dart';
import 'package:nssc/design/notification.dart';
import 'package:nssc/design/account.dart';
import 'package:nssc/shared/notificationView.dart';

class HomePage extends StatefulWidget {
  int counter = 0;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    new MyNotification();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int counter = HomePage().counter;
    Color _colorFromHex(String hexColor) {
      final hexCode = hexColor.replaceAll('#', '');
      return Color(int.parse('FF$hexCode', radix: 16));
    }
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Container(
      child: DefaultTabController(
        length: 3,
        child: new Scaffold(
//            appBar: AppBar(
//              backgroundColor: Colors.white, // status bar color
//              brightness: Brightness.light, // status bar brightness
//            ),
          body: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                    height: deviceHeight * 1,
                    decoration: new BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: _colorFromHex("#EBEBEB"),
                          blurRadius: 3,
                        )
                      ],
                    )
                ),
                TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    new ClipRRect(
                      child: Home(),
                    ),
                    new Container(
//                      child: Notif(null),
                      child: MyNotificationList(),
                    ),
                    new Container(
                      child: account(),
                    ),
                  ],
                )
              ]
          ),
          bottomNavigationBar: new TabBar(
            tabs: [
              Tab(
                icon: new Icon(Icons.home),
              ),
              Tab(
                icon: new Stack(
                  children: <Widget>[
                    new Icon(Icons.notifications),
                    if (counter > 0)
                    new Positioned(
                      right: 0,
                      child: new Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: new Text(
                          '$counter',
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Tab(
                icon: new Icon(Icons.perm_identity),
              ),
            ],
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.white,
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
