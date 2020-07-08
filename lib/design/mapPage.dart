import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nssc/design/homePage.dart';
import 'package:permission/permission.dart';
import 'package:nssc/shared/notificationView.dart';
import 'package:nssc/design/home.dart';

void main() => runApp(MapPage());

class MapPage extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapPage> {
  @override
  void initState() {
    new MyNotification();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //To Require Permission
    Permission.openSettings;
    GoogleMapController mapController;
    final LatLng _center = const LatLng(21.0535501, 105.7395092);

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }
    return MaterialApp(
      home: Container(
        //color: Colors.white,
        //padding: EdgeInsets.only(top: 80),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(top: 30),
              child: Column(
                children: <Widget>[
                FlatButton(
                          onPressed: () {Navigator.pop(context);},
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text("< Quay lại", style: new TextStyle(color: Colors.orange, fontSize: 16),),
                    ),
                  )
                ),
                ],
              )
            ),
            Expanded(
              child: Scaffold(
                body: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}