import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nssc/design/DetailNews.dart';
import 'package:nssc/shared/notificationView.dart';
class ListNews extends StatefulWidget {
  @override
  _ListNewsState createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNews> {
  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));    }
  @override
  void initState() {
    _makeHttpPost();
    new MyNotification();
    super.initState();
  }
  List<dynamic> list = null;
  int statusCode = 0;
  String message = "";
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

  Widget _buildRowNews(dynamic news){
    double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        //_makeHttpPostValue(news["ID"].toString());
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailNews(newsId: int.parse(news["ID"].toString()),)));
      },
      child: Container(
          height: 100,
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

