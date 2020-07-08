import 'package:flutter/material.dart';
import 'package:flutter_html/image_properties.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'dart:convert';
import 'package:nssc/shared/notificationView.dart';
import 'package:html/dom.dart' as dom;
// ignore: must_be_immutable
class DetailNews extends StatefulWidget {
  int newsId = 0;
  String title;
  String message;
  String guid;
  DetailNews({@required this.newsId});
  @override
  _DetailNewsState createState() => _DetailNewsState(newsId);
}
class _DetailNewsState extends State<DetailNews> {
  int newsId = 0;
  String title = "";
  String message = "";
  List<dynamic> list;
  _DetailNewsState(this.newsId);
  @override
  void initState() {
    _makeHttpPost();
    super.initState();
//    new MyNotification();
  }
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
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
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        width: deviceWidth,
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Column(
                          children: [
                            Container(
                              child: Text(list == null ? "" : list[0]["post_title"].toString(), style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.justify,),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Image.network(
                              list == null ? "" : list[0]["guid"],
                              //height: 300,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Html(
                            data: list == null ? "" : list[0]["post_content"].toString(), //html string to be parsed
                            useRichText: true,
                            defaultTextStyle: TextStyle(fontSize: 14),


                            onImageTap: (src) {

                            },

                            onLinkTap: (url) {
                              // open url in a webview
                            },
                          ),
                          //Text("You just clicked on the flutter logo!")
                        ),
                      )
                    ],
                  ),
              )
            ]
          )
        )
    );
  }

  _makeHttpPost() async {
    print("Run init here");
    var client = http.Client();
    Map data = {
      'ID': newsId,
      'post_title': '',
      'post_content': '',
      'guid': '',
      'url': ''
    };
    //encode Map to JSON
    var body = json.encode(data);
    final response = await client.post(
        "http://123.31.12.96/News/GetNewsById", headers: {"Content-Type": "application/json"}, body: body);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var post = Post.fromJson(jsonDecode(response.body));
      setState(() {
        message = post.message;
        title = post.title;
        list = post.list;
      });
    }
  }
}
class Post{
  int statusCode;
  String message;
  String title;
  String newsData;
  List<dynamic> list;
  Post({this.title, this.message, this.list});
  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
        title: json['post_title'],
        message: json['post_content'],
        list: json['Data'].toList(),
    );
  }
}
