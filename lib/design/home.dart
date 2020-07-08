import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_html/style.dart';
import 'package:nssc/design/DetailDuAn.dart';
import 'package:nssc/design/contactPage.dart';
import 'package:nssc/design/listExpert.dart';
import 'package:nssc/design/mapPage.dart';
import 'package:permission/permission.dart';
import 'package:http/http.dart' as http;
import 'package:nssc/design/DetailNews.dart';
import 'package:nssc/design/listNewsPage.dart';
import 'package:nssc/shared/notificationView.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nssc/design/listDuAnPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_html/flutter_html.dart';

class _HomeState extends State<Home> {
  List<dynamic> list = null;
  List<dynamic> listProject = null;
  int statusCode = 0;
  String message = "";
  //Project

  String statusMessage = "";

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));    }
  final List<String> imgList = [
    'assets/nsscbanner.jpg',
    'assets/nsscbanner.jpg',
  ];

  @override
  void initState() {
    _makeHttpPost();
    _makeHttpGetProject();
    new MyNotification();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    //To Require Permission
    Permission.openSettings;
    return Container(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 5,
            runSpacing: 5,
            children: [
              Column(
                children: <Widget>[
                  Image(image: AssetImage('assets/nssc.png'), width: 182, height: 46,),
                ],
              ),
            ],
          ),
          Container(
            width: deviceWidth * 0.9,
            height: 50,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(top:1.5, bottom: 1.5, left: 1.5, right: 1.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
            ),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Tìm theo dự án...",
                labelText: "Tìm theo dự án...",
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
            height: 165,
            padding: EdgeInsets.only(top: 10),
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                //aspectRatio: 5.0,
              ),
              items: imgList.map((item) => Container(
                child: Center(
                    child: Image(image: AssetImage('assets/nsscbanner.jpg'), width: deviceWidth * 1, height: 155, fit: BoxFit.fill,),
                ),
              )).toList(),
            )
          ),
          //Container Đăng nhập
//          if(_loginToken == null || _loginToken == "")
//            Container(
//                width: deviceWidth * 0.9,
//                height: 90,
//                padding: EdgeInsets.all(1.5),
//                decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(10),
//                    boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
//                ),
//                child: Container(
//                  //color: Colors.white,
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10),
//                      border: Border.all(color: _colorFromHex("#cccccc"), width: 1),
//                      boxShadow: [BoxShadow(color: Colors.white)]
//                  ),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: <Widget>[
//                      ClipRRect(
//                        child: Column(
//                          children: <Widget>[
//                            Container(
//                                width: deviceWidth * 0.6,
//                                padding: EdgeInsets.only(left: 20, top: 20, right: 20),
//                                child: new Wrap(
//                                  direction: Axis.horizontal,
//                                  crossAxisAlignment: WrapCrossAlignment.start,
//                                  spacing: 5,
//                                  runSpacing: 5,
//                                  children: [
//                                    Column(
//                                      children: <Widget>[
//                                        new RichText(
//                                          text: new TextSpan(
//                                            // Note: Styles for TextSpans must be explicitly defined.
//                                            // Child text spans will inherit styles from parent
//                                            style: new TextStyle(
//                                              color: Colors.black,
//                                            ),
//                                            children: <TextSpan>[
//                                              new TextSpan(text: 'Đăng nhập', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
//                                              new TextSpan(text: ' để nhận thông tin dự án mới nhất từ NSSC', style: new TextStyle(fontSize: 17)),
//                                            ],
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ],
//                                )
//                            ),
//
//                          ],
//                        ),
//                      ),
//                      Expanded(
//                          child: new Wrap(
//                            direction: Axis.horizontal,
//                            crossAxisAlignment: WrapCrossAlignment.end,
//                            spacing: 5,
//                            runSpacing: 5,
//                            children: [
//                              Column(
//                                children: <Widget>[
//                                  new Container(
//                                    child: Column(
//                                      children: <Widget>[
//                                        ButtonTheme(
//                                          minWidth: 100,
//                                          height: 50,
//                                          child: RaisedButton(
//                                            color: _colorFromHex("#E89A52"),
//                                            onPressed: () {
//                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage())).then((value) {
//                                                setState(() {
//                                                  _loginToken = value;
//                                                });
//                                              });
//                                            },
//                                            shape: RoundedRectangleBorder(
//                                                borderRadius: BorderRadius.circular(10)
//                                            ),
//                                            child: Text("Đăng nhập", style: TextStyle(color: Colors.white)),
//                                          ),
//                                        )
//                                      ],
//                                    ),
//                                  )
//                                ],
//                              ),
//                            ],
//                          )
//                      )
//                    ],
//                  ),
//                )
//            ),

          // List du an
          Container(
            height: 240,
            child: Column(
              children: [
                Container(
                  height: 120,
                  padding: EdgeInsets.only(left: 20),
                  child: ListView(
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 20, left: 10, right: 7),
                        width: deviceWidth * 0.2,
                        child: Column(
                          children: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListDuAn()));
                                },
                                padding: EdgeInsets.all(0.0),
                                child: Image.asset('assets/duan.jpeg')
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Dự án", style: new TextStyle(fontSize: 13),)
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20, left: 10, right: 7),
                        width: deviceWidth * 0.205,
                        child: Column(
                          children: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact()));
                                },
                                padding: EdgeInsets.all(0.0),
                                child: Image.asset('assets/congty.jpeg')),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Công ty", style: new TextStyle(fontSize: 13),)
                          ],
                        ),
                      ),
//                Container(
//                  padding: EdgeInsets.only(top: 20, left: 10, right: 7),
//                  width: deviceWidth * 0.2,
//                  child: Column(
//                    children: <Widget>[
//                      FlatButton(
//                          onPressed: () {
//                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapPage()));
//                          },
//                          padding: EdgeInsets.all(0.0),
//                          child: Image.asset('assets/quanhday.jpeg')),
//                      SizedBox(
//                        height: 8,
//                      ),
//                      Text("Quanh đây", style: new TextStyle(fontSize: 13),)
//                    ],
//                  ),
//                ),
                      Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListExpert()))
                                },
                                child: Container(
                                  width: deviceWidth * 0.162,
                                  //height: deviceHeight * 0.2,
                                  margin: EdgeInsets.only(top: 20, bottom: 0, left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: _colorFromHex("#2b9cde"),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(19),
                                        color: Colors.white
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                        ),
                                        child: Image.asset('assets/expert.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 7),
                                child: Text("Chuyên gia", style: new TextStyle(fontSize: 13),),
                              )

                            ],
                          )
                      ),

                      Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact()))
                                },
                                child: Container(
                                  width: deviceWidth * 0.162,
                                  margin: EdgeInsets.only(top: 20, bottom: 0, left: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: _colorFromHex("#2b9cde"),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(19),
                                        color: Colors.white
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                        ),
                                        child: Image.asset('assets/daotao.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Text("Đào tạo", style: new TextStyle(fontSize: 13),),
                              )
                            ],
                          )
                      ),

                    ],
                  ),
                ),
                Container(
                  height: 120,
                  padding: EdgeInsets.only(left: 20),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact()))
                                },
                                child: Container(
                                  width: deviceWidth * 0.162,
                                  margin: EdgeInsets.only(top: 20, bottom: 0, left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: _colorFromHex("#2b9cde"),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(19),
                                        color: Colors.white
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                        ),
                                        child: Image.asset('assets/congnghe.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 17),
                                child: Text("Công nghệ", style: new TextStyle(fontSize: 13),),
                              )
                            ],
                          )
                      ),
                      Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact()))
                                },
                                child: Container(
                                  width: deviceWidth * 0.162,
                                  margin: EdgeInsets.only(top: 20, bottom: 0, left: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: _colorFromHex("#2b9cde"),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(19),
                                        color: Colors.white
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                        ),
                                        child: Image.asset('assets/doitac.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Text("Đối tác", style: new TextStyle(fontSize: 13),),
                              )
                            ],
                          )
                      ),
                      Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact()))
                                },
                                child: Container(
                                  width: deviceWidth * 0.162,
                                  margin: EdgeInsets.only(top: 20, bottom: 0, left: 18),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: _colorFromHex("#2b9cde"),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(19),
                                        color: Colors.white
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                        ),
                                        child: Image.asset('assets/marketing.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 17),
                                child: Text("Marketing", style: new TextStyle(fontSize: 13),),
                              )
                            ],
                          )
                      ),
                      Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Contact()))
                                },
                                child: Container(
                                  width: deviceWidth * 0.162,
                                  margin: EdgeInsets.only(top: 20, bottom: 0, left: 18),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: _colorFromHex("#2b9cde"),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(19),
                                        color: Colors.white
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                        ),
                                        child: Image.asset('assets/phaply.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Text("Pháp lý", style: new TextStyle(fontSize: 13),),
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: deviceWidth * 0.6,
                  child: Text("Dự án", textAlign: TextAlign.left, style: new TextStyle(fontSize: 24)),
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
                          child: Text("Xem thêm >", style: new TextStyle(color: Colors.orange, fontSize: 16),),
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        Container(
          width: deviceWidth * 0.5,
          height: 340,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listProject == null ? 0 : listProject.length,
            itemBuilder: (context, index){
              return _buildRowDuAn(listProject[index]);
            },
          ),
        ),

          Container(
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: deviceWidth * 0.6,
                  child: Text("Tin tức", textAlign: TextAlign.left, style: new TextStyle(fontSize: 24)),
                ),
                Container(
                  width: deviceWidth * 0.3,
                  child: FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context){
                          return new ListNews();
                        }));
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: Text("Xem thêm >", style: new TextStyle(color: Colors.orange, fontSize: 16),),
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
          Container(
            width: deviceWidth * 0.9,
            height: 580,
            child:
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: list == null ? 0 : list.length,
              itemBuilder: (context, index){
                return _buildRowNews(list[index]);
              },
            ),
          ),

          Container(
            width: deviceWidth * 0.9,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute<Null>(builder: (BuildContext context){
                  return new ListNews();
                }));
              },
              child: Container(
                width: deviceWidth * 0.9,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.blue, width: 2)
                ),
                alignment: Alignment.center,
                child: Text("Xem tất cả tin tức", style: new TextStyle(fontSize: 16, color: Colors.blue)),
              ),
            ),
          )
        ],
      )
    );
  }

  _makeHttpGetProject(){

    final response = http.get("http://api-plf.1sg.vn/api/GetProject?id=&IndustrialCategoryID=&ProvinceID&_TextSearch=&_PageIndex=1&_PageSize=10");
    response.then((value){
    if(value.statusCode == 200){
      print(value.body);
        var postProject = PostProject.fromJson(jsonDecode(value.body));
        setState(() {
          statusCode = postProject.statusCode;
          statusMessage = postProject.status;
          listProject = postProject.listProject;
        });
      }
      else{
        print(value.statusCode);
      }
    });
  }

  _makeHttpPost(){
    final response = http.post("http://123.31.12.96/News/GetHighLight");
    response.then((value){
      if(value.statusCode == 200){
        print(value.body);
        var post = Post.fromJson(jsonDecode(value.body));
        setState(() {
          statusCode = post.statusCode;
          message = post.message;
          list = post.list;
        });
      }
      else{
        print("Error");
      }
    });

  }

//  _makeHttpPostValue(String newsId) async {
//    var client = http.Client();
//    final response = await client.post(
//        "http://123.31.12.96/News/GetNewsById", body: {
//      'ID': newsId,
//      'post_title': '',
//      'post_content': '',
//      'guid': '',
//      'url': ''
//    });
//    print("click here");
//    if (response.statusCode == 201) {
//      var post = Post.fromJson(jsonDecode(response.body));
//      setState(() {
//        message = post.message;
//        list = post.list;
//      });
//    }
//  }
  Widget _buildRowDuAn(dynamic projects) {
    double deviceWidth = MediaQuery.of(context).size.width;

    //return new MyNotification();
    return GestureDetector(
      onTap: (){
        //_makeHttpPostValue(news["ID"].toString());
        print('Du an: $projects');
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailDuAn(newsId: int.parse(projects["ID"].toString()),)));
      },
      child: Container(
        height: 180,
        width: deviceWidth * 0.6,
        padding: EdgeInsets.only( right: 20),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(1.5),
              height: 330,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: _colorFromHex("#EBEBEB"))]
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: _colorFromHex("#cccccc"), width: 1),
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
                            projects["IMG"] == null ? "" : projects["IMG"],
                            //height: 300,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: deviceWidth * 0.9,
                      padding: EdgeInsets.only(top: 5, right: 15, left: 15),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Container(
                          width: deviceWidth * 0.9,
                          padding: EdgeInsets.only(left: 17, right: 17, top: 5),
                          //height: 160,
                          child: Text(projects["TITLE"].toString().length >= 35 ? projects["TITLE"].toString().substring(0, 35) + "..." : projects["TITLE"].toString(), textAlign: TextAlign.justify, style: new TextStyle(fontSize: 34)),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: deviceWidth * 0.68,
                      padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                      child: Text(projects["SHORT_DES"]
                          .toString()
                          .length >= 55 ? projects["SHORT_DES"]
                          .toString()
                          .substring(0, 55) + "..." : projects["SHORT_DES"]
                          .toString(), textAlign: TextAlign.justify,
                          style: new TextStyle(fontSize: 14)) //Text(projects["SHORT_DES"].toString().length >= 55 ? projects["SHORT_DES"].toString().substring(0, 55) + "..." : projects["SHORT_DES"].toString(), textAlign: TextAlign.justify, style: new TextStyle(fontSize: 13)),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildRowNews(dynamic news){
    double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        //_makeHttpPostValue(news["ID"].toString());
        print('Tin tuc: $news');
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailNews(newsId: int.parse(news["ID"].toString()),)));
      },
      child: Container(
          height: 100,
          width: deviceWidth * 0.9,
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
                  width: deviceWidth * 0.3,
                  height: 130,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30)
                      ),
                      child: Image.network(
                        news["guid"],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: deviceWidth * 0.6,
                    height: 130,
                    padding: EdgeInsets.only(left: 15, right: 10, top: 15),
                    child: Text(news["post_title"].toString().length > 150 ? news["post_title"].toString().substring(0, 150) + "..." : news["post_title"].toString(), style: new TextStyle(fontSize: 14)),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}

class Home extends StatefulWidget {
  _HomeState parent;
  Home({Key key, this.title, this.parent}) : super(key: key);
//  void refreshLogin(String tokenKey){
//    parent.setState(() {
//      parent._loginToken = tokenKey;
//    });
//  }
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class Post{
  int statusCode;
  String message;
  String title;
  String newsData;
  List<dynamic> list;
  Post({this.title, this.newsData, this.list, this.statusCode, this.message});
  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      list: json['Data'].toList(),
      statusCode: int.tryParse(json['statusCode'].toString()) ?? 0,
      message: json['message']
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
