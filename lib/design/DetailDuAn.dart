import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/image_properties.dart';
//import 'package:flutter_html/style.dart';
import 'package:http/http.dart' as http;
import 'package:nssc/design/expertDetail.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:flutter_html/html_parser.dart';
import 'package:html/dom.dart' as dom;
import 'package:pattern_formatter/pattern_formatter.dart';

import 'listDuAnPage.dart';

class DetailDuAn extends StatefulWidget {
  int newsId = 0;
  String title;
  String message;
  String guid;
  DetailDuAn({@required this.newsId});
  @override
  _DetailDuAnState createState() => _DetailDuAnState(newsId);
}

class _DetailDuAnState extends State<DetailDuAn> {
  int projectId = 0;
  String title = "";
  String message = "";
  List<dynamic> list;
  List<dynamic> listOther;
  int statusCode;
  String statusMessage = "";
  List<dynamic> listProject = null;
  List<dynamic> listProjectById = null;
  List<dynamic> listExpert = null;
  final controllerDauTu = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerDauTu.dispose();
    super.dispose();
  }
  _DetailDuAnState(this.projectId);

  @override
  void initState() {
    _makeHttpGetProjectById();
    _makeHttpGetProjectOther();
    _makeHttpGetExpert();
    super.initState();
//    new MyNotification();
  }

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Quay lại"),
      ),
      body: Container(
          width: deviceWidth,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Container(
                    width: deviceWidth,
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Image.network(
                          listProjectById == null || listProjectById[0]["IMG"] == null ? "" : listProjectById[0]["IMG"],
                          //height: 300,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Dự án", style: new TextStyle(color: Colors.blue, fontSize: 14),),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text(listProjectById == null || listProjectById[0]["TITLE"] == null ? "" : listProjectById[0]["TITLE"]
                              .toString(), style: new TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.justify,),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            listProjectById == null || listProjectById[0]["SHORT_DES"] == null ? "" : listProjectById[0]["SHORT_DES"]
                                .toString(), style: new TextStyle(fontSize: 14),
                            textAlign: TextAlign.justify,),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Mô tả",
                            textAlign: TextAlign.left,
                            style: new TextStyle(fontSize: 20)),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: deviceWidth,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Container(
                              width: deviceWidth * 1,
//                              child: Text(listProjectById == null ? "" : listProjectById[0]["CONTENT"], style: new TextStyle(fontSize: 16),),
                            child: Html(
                              data: listProjectById == null || listProjectById[0]["CONTENT"] == null ? "" : listProjectById[0]["CONTENT"].toString(), //html string to be parsed

                              useRichText: true,
                              defaultTextStyle: TextStyle(fontSize: 14),

                              onImageTap: (src) {

                              },

                              onLinkTap: (url) {
                                // open url in a webview
                              },

                              //(optional) used for override dom elements formatting

                            ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Đầu tư cho dự án",
                            textAlign: TextAlign.left,
                            style: new TextStyle(fontSize: 20)),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: deviceWidth * 0.65,
                                height: 50,
                                margin: EdgeInsets.only(top: 10, right: 10),
                                padding: EdgeInsets.only(top:1.5, bottom: 1.5, left: 1.5, right: 1.5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: controllerDauTu,
                                  decoration: InputDecoration(
                                    hintText: "Số tiền đầu tư",
                                    labelText: "Số tiền đầu tư",
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                    enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0),
                                        borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1.0)),
                                    focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0), borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1),),
                                  ),
                                  inputFormatters: [
                                    ThousandsFormatter(),
                                  ],
                                ),
                              ),
                          Expanded(
                          child: new Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            spacing: 5,
                            runSpacing: 5,
                            children: [
                              Column(
                                      children: <Widget>[
                                        new Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Column(
                                            children: <Widget>[
                                              ButtonTheme(
                                                minWidth: 100,
                                                height: 45,
                                                child: RaisedButton(
                                                  color: _colorFromHex("#E89A52"),
                                                  onPressed: () {
                                                    var amount = controllerDauTu.text;
                                                    print(amount);
                                                    var iAmount = int.parse(amount.toString().replaceAll(",", "").trim());
                                                    print(iAmount);
                                                    if(iAmount < 10000){
                                                      animated_dialog_box.showScaleAlertBox(
                                                          title: Center(child: Text("Thông báo")),
                                                          // IF YOU WANT TO ADD
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
                                                          icon: Icon(Icons.info_outline, color: Colors.red,),
                                                          // IF YOU WANT TO ADD ICON
                                                          yourWidget: Container(
                                                            child: Text(
                                                                'Số tiền đầu tư không hợp lệ. Số tiên tối thiểu 10,000 VND.'),
                                                          ));
                                                    }
                                                    else{
                                                      animated_dialog_box.showScaleAlertBox(
                                                          title: Center(child: Text("Thông báo")),
                                                          // IF YOU WANT TO ADD
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
                                                          icon: Icon(Icons.info_outline, color: Colors.red,),
                                                          // IF YOU WANT TO ADD ICON
                                                          yourWidget: Container(
                                                            child: Text(
                                                                'Bạn đã đầu tư cho dự án thành công.'),
                                                          ));
                                                    }
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: Text("Đầu tư", style: TextStyle(color: Colors.white)),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                width: deviceWidth * 0.65,
                                child: Text("Cũng đang đầu tư",
                                    textAlign: TextAlign.left,
                                    style: new TextStyle(fontSize: 24)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: deviceWidth * 0.5,
                          height: 335,
                          padding: EdgeInsets.only(top: 10),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listExpert == null ? 0 : listExpert.length,
                            itemBuilder: (context, index) {
                              return _buildRowExpert(listExpert[index]);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                width: deviceWidth * 0.65,
                                child: Text("Dự án tương tự",
                                    textAlign: TextAlign.left,
                                    style: new TextStyle(fontSize: 24)),
                              ),
                              Container(
                                width: deviceWidth * 0.3,
                                child: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute<Null>(builder: (BuildContext context){
                                        return new ListDuAn();
                                      }));
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        child: Text("Xem thêm >",
                                          style: new TextStyle(
                                              color: Colors.orange,
                                              fontSize: 16),),
                                      ),
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: deviceWidth * 0.5,
                          height: 335,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listProject == null ? 0 : listProject.length,
                            itemBuilder: (context, index) {
                              return _buildRow(listProject[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)
                    ),
                    child: Row(
                      children: [
                        FlatButton(
                          onPressed: () {

                          },
                          padding: EdgeInsets.only(left: 20),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset('assets/avatar.jpg',
                                width: 60,
                                height: 60,)),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Nguyễn Hưng", style: new TextStyle(fontSize: 20),),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 90),
                            child: GestureDetector(
                                onTap: () {
                                  _launchURL();
                                },

                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset('assets/messicon.jpeg',
                                      width: 40,
                                      height: 40,))
                            )
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            child: GestureDetector(
                              onTap: () {
                                //_makeHttpPostValue(news["ID"].toString());
                                var mobile = listProjectById == null ? "" : listProjectById[0]["PHONENO"];
                                launch("tel:$mobile");
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),

                                  child: Image.asset('assets/callicon.jpeg',
                                    width: 40,
                                    height: 40,)
                              ),
                            )

                        )
                      ],
                    ),
                  )
                ],
              ),

            ],
          )
      ),
    );
  }

  _launchURL() async {
    String mobile = listProjectById == null ? "" : listProjectById[0]["PHONENO"].toString();
    if(mobile.startsWith("0"))
      mobile = "84" + mobile.substring(1);
    var whatsappUrl = "whatsapp://send?phone=$mobile";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      animated_dialog_box.showScaleAlertBox(
          title: Center(child: Text("Thông báo")),
          // IF YOU WANT TO ADD
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
          icon: Icon(Icons.info_outline, color: Colors.red,),
          // IF YOU WANT TO ADD ICON
          yourWidget: Container(
            child: Text(
                'Không thể khởi chạy WhatApps hoặc WhatApps chưa được cài đặt. Vui lòng kiểm tra lại!'),
          ));
    }
  }

  Widget _buildRow(dynamic projects) {
    double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;

    //return new MyNotification();
    return GestureDetector(
      onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailDuAn(newsId: int.parse(projects["ID"].toString()),)));},
      child: Container(
        height: 180,
        width: deviceWidth * 0.6,
        padding: EdgeInsets.only(right: 20),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: _colorFromHex("#cccccc"), width: 1),
                    boxShadow: [BoxShadow(color: Colors.white)]
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: deviceWidth * 0.58,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)
                          ),
                          child: Image.network(
                            projects["IMG"] == null ? "" : projects["IMG"],
                            //height: 300,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      width: deviceWidth * 0.68,
                      padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                      child: Text(projects["TITLE"]
                          .toString()
                          .length >= 35 ? projects["TITLE"]
                          .toString()
                          .substring(0, 35) + "..." : projects["TITLE"]
                          .toString(), textAlign: TextAlign.justify,
                          style: new TextStyle(fontSize: 18)),
                    ),
                    Container(
                      height: 60,
                      width: deviceWidth * 0.68,
                      padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                      child: Text(projects["SHORT_DES"]
                          .toString()
                          .length >= 55 ? projects["SHORT_DES"]
                          .toString()
                          .substring(0, 55) + "..." : projects["SHORT_DES"]
                          .toString(), textAlign: TextAlign.justify,
                          style: new TextStyle(fontSize: 13)),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildRowExpert(dynamic experts) {
    double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;

    //return new MyNotification();
    return GestureDetector(
      onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailExpert(expertId: int.parse(experts["ID"].toString()),)));},
      child: Container(
        height: 180,
        width: deviceWidth * 0.6,
        padding: EdgeInsets.only(right: 20),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: _colorFromHex("#cccccc"), width: 1),
                    boxShadow: [BoxShadow(color: Colors.white)]
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: deviceWidth * 0.58,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                          ),
                          child: Image.network(
                            experts["IMG"] == null ? "" : experts["IMG"],
                            //height: 300,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: deviceWidth * 0.68,
                      padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                      child: Text(experts["FULLNAME"]
                          .toString(), textAlign: TextAlign.justify,
                          style: new TextStyle(fontSize: 18)),
                    ),
                    Container(
                      height: 60,
                      width: deviceWidth * 0.68,
                      padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                      child: Text(experts["SHORT_DES"]
                          .toString(), textAlign: TextAlign.justify,
                          style: new TextStyle(fontSize: 13)),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  _makeHttpGetProjectById() {
    final response = http.get(
        "http://api-plf.1sg.vn/api/GetProject?id=$projectId&IndustrialCategoryID=&ProvinceID&_TextSearch=&_PageIndex=1&_PageSize=10");
    response.then((value) {
      if (value.statusCode == 200) {
        print(value.body);
        var postProject = PostProject.fromJson(jsonDecode(value.body));
        setState(() {
          statusCode = postProject.statusCode;
          statusMessage = postProject.status;
          listProjectById = postProject.listProject;
        });
      }
      else {
        print(value.statusCode);
      }
    });
  }

  _makeHttpGetProjectOther() {
    final response = http.get(
        "http://api-plf.1sg.vn/api/GetProject?id=&IndustrialCategoryID=&ProvinceID&_TextSearch=&_PageIndex=1&_PageSize=10");
    response.then((value) {
      if (value.statusCode == 200) {
        print(value.body);
        var postProject = PostProject.fromJson(jsonDecode(value.body));
        setState(() {
          statusCode = postProject.statusCode;
          statusMessage = postProject.status;
          listProject = postProject.listProject;
        });
      }
      else {
        print(value.statusCode);
      }
    });
  }

  _makeHttpGetExpert() {
    final response = http.get(
        "http://api-plf.1sg.vn/api/GetExpert?id=&IndustrialCategoryID=&ProvinceID=&_TextSearch=&_PageIndex=1&_PageSize=10");
    response.then((value) {
      if (value.statusCode == 200) {
        print(value.body);
        var expert = PostExpert.fromJson(jsonDecode(value.body));
        setState(() {
          statusCode = expert.statusCode;
          statusMessage = expert.status;
          listExpert = expert.listExpert;
        });
      }
      else {
        print(value.statusCode);
      }
    });
  }
}

class PostProject{
  int statusCode;
  String status;
  List<dynamic> listProject;
  PostProject({this.statusCode, this.status, this.listProject});
  factory PostProject.fromJson(Map<String, dynamic> json){
    return PostProject(
        statusCode: json['statusCode'],
        status: json['status'],
        listProject: json['respObj']
    );
  }
}

class PostExpert{
  int statusCode;
  String status;
  List<dynamic> listExpert;
  PostExpert({this.statusCode, this.status, this.listExpert});
  factory PostExpert.fromJson(Map<String, dynamic> json){
    return PostExpert(
        statusCode: json['statusCode'],
        status: json['status'],
        listExpert: json['respObj']
    );
  }
}