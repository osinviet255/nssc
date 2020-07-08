import 'dart:async';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nssc/design/home.dart';
import 'package:nssc/design/notification.dart';
import 'package:nssc/design/account.dart';
import 'package:nssc/model/NotificationData.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}
final Map<String, Item> _items = <String, Item>{};
Item _itemForMessage(Map<String, dynamic> message) {
  final dynamic data = message['data'] ?? message;
  final dynamic notification = message["notification"] ?? message;
  if(data != null){
  final String itemId = data['id'];
  print(notification);
  final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
    ..title = notification['title']
    ..body = notification['body']
    ..khoangcach = data['khoangcach'];
  return item;
  }
  return null;
}

class Item {
  Item({this.itemId});
  final String itemId;

  StreamController<Item> _controller = StreamController<Item>.broadcast();
  Stream<Item> get onChanged => _controller.stream;

  String _title;
  String get title => _title;
  set title(String value){
    _title = value;
    _controller.add(this);
  }

  String _body;
  String get body => _body;
  set body(value){
    _body = value;
    _controller.add(this);
  }


  String _khoangcach;
  String get khoangcach => _khoangcach;
  set khoangcach(String value) {
    _khoangcach = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    final String routeName = '/detail/$itemId';
    return routes.putIfAbsent(
      routeName,
          () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => Notif(itemId),
      ),
    );
  }
}

class Notif extends StatefulWidget {
  Notif(this.itemId);
  final String itemId;
  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  Item _item;
  StreamSubscription<Item> _subscription;
  @override
  void initState() {
    super.initState();
    _item = _items[widget.itemId];
    _subscription = _item.onChanged.listen((Item item) {
      if (!mounted) {
        _subscription.cancel();
      } else {
        setState(() {
          _item = item;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyNotification extends StatefulWidget {
  _MyNotificationState parent;
  MyNotification({Key key, this.title, this.parent}) : super(key: key);
  void refresh(){
    parent.setState(() {
      parent._counter = 0;
    });
  }
  final String title;
  @override
  _MyNotificationState createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  bool _topicButtonsDisabled = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final TextEditingController _topicController =
  TextEditingController(text: 'topic');
  int _counter = 0;
  String khoangcach = "";
  String title = "";
  String body = "";
  NotificationData notificationData;
  List<NotificationData> _list = [];
  List<int> dsint = new List<int>();
  var myList = List();
//  void _showItemNotifi(Map<String, dynamic> message) {
//    showDialog<bool>(
//      context: context,
//      builder: (_) => _buildDialog(context, _itemForMessage(message)),
//    ).then((bool shouldNavigate) {
//      if (shouldNavigate == true) {
//        _navigateToItemDetail(message);
//      }
//    });
//  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final Item item = _itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }
  @override
  void initState() {
    super.initState();
    print("Init FireBase");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        setState(() {
          _counter++;
          print(message['data']);
          Item item = _itemForMessage(message);
          khoangcach = item.khoangcach;
          title = item.title;
          body = item.body;
          notificationData = new NotificationData();
          notificationData.khoangcach = khoangcach;
          notificationData.title = title;
          notificationData.body = body;
          _list.add(notificationData);
        });
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });
//    _firebaseMessaging.subscribeToTopic("tieude");
  }
  @override
  Widget build(BuildContext context) {
    print(_counter);
    Color _colorFromHex(String hexColor) {
      final hexCode = hexColor.replaceAll('#', '');
      return Color(int.parse('FF$hexCode', radix: 16));
    }
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);


    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: new Scaffold(
//            appBar: AppBar(
//              backgroundColor: Colors.white, // status bar color
//              brightness: Brightness.light, // status bar brightness
//              title: Text('$titlebar', style: new TextStyle(color: Colors.black),),
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
                      child: MyNotificationList(list: _list,),
                    ),
                    new Container(
                      child: account(),
                    ),
                  ],
                )
              ]
          ),
          bottomNavigationBar: new TabBar(
            onTap: (index){
              switch(index){
                case 1:
                  refresh();
              }
            },
            tabs: [
              Tab(
                icon: new Icon(Icons.home),
              ),
              Tab(
                icon: new Stack(
                  children: <Widget>[
                    new Icon(Icons.notifications),
                    if ( _counter > 0)
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
                            '$_counter',
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
  void refresh(){
    setState(() {
      _counter = 0;
    });
  }
}

class NotifData{
  String tieude;
  String noidung;
  NotifData({this.tieude, this.noidung});
  factory NotifData.fromJson(Map<String, dynamic> json){
    return NotifData(
        tieude: json['tieude'],
        noidung: json['noidung']
    );
  }

}

