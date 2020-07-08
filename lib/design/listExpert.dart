import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nssc/shared/notificationView.dart';
import 'package:http/http.dart' as http;

import 'expertDetail.dart';

class ListExpert extends StatefulWidget {
  @override
  _ListExpertState createState() => _ListExpertState();
}

class _ListExpertState extends State<ListExpert> {
  int statusCode = 0;
  String message = "";
  //Project

  String statusMessage = "";
  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));    }
  @override
  void initState() {
    _makeHttpGetProject();
    new MyNotification();
    super.initState();
  }
  List<dynamic> list = null;
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Quay lại"),
      ),
      body: Container(
        width: deviceWidth,
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: ListView.builder(
          itemCount: list == null ? 0 : list.length,
          itemBuilder: (context, index){
            return _buildRowNews(list[index]);
          },
        ),
      ),
    );
  }
  _makeHttpGetProject(){

    final response = http.get("http://api-plf.1sg.vn/api/GetExpert?id=&IndustrialCategoryID=&ProvinceID=&_TextSearch=&_PageIndex=1&_PageSize=10");
    response.then((value){
      if(value.statusCode == 200){
        print(value.body);
        var postProject = PostProject.fromJson(jsonDecode(value.body));
        setState(() {
          statusCode = postProject.statusCode;
          statusMessage = postProject.status;
          list = postProject.listProject;
        });
      }
      else{
        print(value.statusCode);
      }
    });
  }

  Widget _buildRowNews(dynamic experts){
    double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailExpert(expertId: int.parse(experts["ID"].toString()),)));
      },
      child: Container(
          height: 160,
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
            child: Row(
              children: <Widget>[
                Container(
                  width: deviceWidth * 0.4,
                  height: 160,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                      ),
                      child: Image.network(
                        experts["IMG"] == null ? "" : experts["IMG"],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: deviceWidth * 0.5,
                        height: 20,
                        padding: EdgeInsets.only(left: 15, right: 10, top: 5),
                        child: Text(experts["FULLNAME"].toString().length > 150 ? experts["FULLNAME"].toString().substring(0, 150) + "..." : experts["FULLNAME"].toString(), style: new TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        width: deviceWidth * 0.5,
                        height: 130,
                        padding: EdgeInsets.only(left: 15, right: 10, top: 5),
                        child: Text(experts["SHORT_DES"].toString().length > 150 ? experts["SHORT_DES"].toString().substring(0, 150) + "..." : experts["SHORT_DES"].toString(), style: new TextStyle(fontSize: 14)),
                      ),
                    ],
                  )
                )
              ],
            ),
          )
      ),
    );
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