import 'package:flutter/material.dart';
import 'package:animated_dialog_box/animated_dialog_box.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
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
                child: Text("Liên hệ", style: new TextStyle(color: Colors.blue, fontWeight: FontWeight.normal),),
              )
          )
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                Container(
                  width: deviceWidth * 0.95,
                  height: 50,
                  margin: EdgeInsets.only(top: 10,left: 10),
                  padding: EdgeInsets.only(top:1.5, bottom: 1.5, left: 1.5, right: 1.5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.supervisor_account),
                      hintText: "Họ tên",
                      labelText: "Họ tên",
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1.0)),
                      focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0), borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1),),
                    ),
                  ),
                ),
                Container(
                  width: deviceWidth * 0.95,
                  height: 50,
                  margin: EdgeInsets.only(top: 10, left: 10),
                  padding: EdgeInsets.only(top:1.5, bottom: 1.5, left: 1.5, right: 1.5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                      labelText: "Email",
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1.0)),
                      focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0), borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1),),
                    ),
                  ),
                ),
                Container(
                  width: deviceWidth * 0.95,
                  height: 50,
                  margin: EdgeInsets.only(top: 10, left: 10),
                  padding: EdgeInsets.only(top:1.5, bottom: 1.5, left: 1.5, right: 1.5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: "Số điện thoại",
                      labelText: "Số điện thoại",
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1.0)),
                      focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0), borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1),),
                    ),
                  ),
                ),
                Container(
                  width: deviceWidth * 0.95,
                  height: 50,
                  margin: EdgeInsets.only(top: 10, left: 10),
                  padding: EdgeInsets.only(top:1.5, bottom: 1.5, left: 1.5, right: 1.5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.title),
                      hintText: "Tiêu đề",
                      labelText: "Tiêu đề",
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1.0)),
                      focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0), borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1),),
                    ),
                  ),
                ),
                Container(
                  width: deviceWidth * 0.95,
                  height: 250,
                  margin: EdgeInsets.only(top: 10, left: 10),
                  padding: EdgeInsets.only(top:1.5, bottom: 1.5, left: 1.5, right: 1.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
//                  boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.content_paste),
                      hintText: "Nội dung",
                      labelText: "Nội dung",
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1.0)),
                      focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0), borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1),),
                    ),
                    style: TextStyle(
                        height: 1.0,
                        color: Colors.black
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
                RaisedButton(
                  color: _colorFromHex("#E89A52"),
                  onPressed: () async {
                    animated_dialog_box.showScaleAlertBox(
                        title:Center(child: Text("Liên hệ")) , // IF YOU WANT TO ADD
                        context: context,
                        firstButton: MaterialButton(
                          // FIRST BUTTON IS REQUIRED
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          color: Colors.white,
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        icon: Icon(Icons.info_outline,color: Colors.red,), // IF YOU WANT TO ADD ICON
                        yourWidget: Container(
                          child: Text('Gửi thông tin thành công.'),
                        ));
//                Navigator.pop(context, tokenReturn);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("Gửi thông tin", style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ],
      )
    );
}
}
