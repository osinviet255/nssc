import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';


class DetailExpert extends StatefulWidget {
  int expertId = 0;
  String title;
  String message;
  String guid;
  DetailExpert({@required this.expertId});
  @override
  _DetailExpertState createState() => _DetailExpertState(expertId);
}

class _DetailExpertState extends State<DetailExpert> {
  int expertId = 0;
  String title = "";
  String message = "";
  int statusCode;
  String statusMessage = "";
  List<dynamic> listExpert = null;
  _DetailExpertState(this.expertId);
  @override
  void initState() {
    _makeHttpGetExpert(expertId);
    super.initState();
//    new MyNotification();
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
                          listExpert == null || listExpert[0]["IMG"] == null ? "" : listExpert[0]["IMG"],
                          height: 300,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Chuyên gia", style: new TextStyle(color: Colors.blue, fontSize: 14),),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text(listExpert == null || listExpert[0]["FULLNAME"] == null ? "" : listExpert[0]["FULLNAME"]
                              .toString(), style: new TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.justify,),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            listExpert == null || listExpert[0]["SHORT_DES"] == null ? "" : listExpert[0]["SHORT_DES"]
                                .toString(), style: new TextStyle(fontSize: 14),
                            textAlign: TextAlign.justify,),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Thông tin chi tiết",
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
                                data: listExpert == null || listExpert[0]["CONTENT"] == null ? "" : listExpert[0]["CONTENT"].toString(), //html string to be parsed

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
                      ],
                    ),
                  )
              ),
            ],
          )
      ),
    );
  }

  _makeHttpGetExpert(int expertId) {
    final response = http.get(
        "http://api-plf.1sg.vn/api/GetExpert?id=$expertId&IndustrialCategoryID=&ProvinceID=&_TextSearch=&_PageIndex=1&_PageSize=10");
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