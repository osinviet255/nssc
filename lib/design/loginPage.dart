import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:animated_dialog_box/animated_dialog_box.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _tokenString = "";
  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));    }
  final controllerUser = TextEditingController();
  final controllerPassword = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerUser.dispose();
    controllerPassword.dispose();
    super.dispose();
  }
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
                child: Text("Login", style: new TextStyle(color: Colors.blue, fontWeight: FontWeight.normal),),
              )
          )
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50),
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
                  hintText: "Username",
                  labelText: "Username",
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1.0)),
                  focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0), borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1),),
                ),
                controller: controllerUser,
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
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Password",
                  labelText: "Password",
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1.0)),
                  focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0), borderSide: BorderSide(color: _colorFromHex("#cccccc"), width: 1),),
                ),
                controller: controllerPassword,
              ),
            ),
            RaisedButton(
              color: _colorFromHex("#E89A52"),
//              onPressed: () {
//                Future<String> futureLoginApi = _loginApiPost(controllerUser.text, controllerPassword.text);
//                futureLoginApi.then((value) => {
//                Navigator.pop(context, value)
//                });
                  onPressed: () async {
                    Future<String> futureLoginApi = _loginApiPost(controllerUser.text, controllerPassword.text);
                    futureLoginApi.then((value) => {
                      if(value == null || value == ""){
                        animated_dialog_box.showScaleAlertBox(
                        title:Center(child: Text("Login")) , // IF YOU WANT TO ADD
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
                        child: Text('Login failed. Please try again!'),
                        ))
                      }
                      else{
                        Login(value, controllerUser.text, controllerPassword.text)
                      }
                    });

//                Navigator.pop(context, tokenReturn);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text("Đăng nhập", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
  Future<String> _loginApiPost(String userName, String password) async{
    final response = await http.post("http://103.226.250.13:7001/NSSC-API-Connect/api_authentication?username=apiuser&password=123456");
    if(response.statusCode == 200){
        return _tokenString = response.headers.toString().split("authorization:")[1].toString().trim().split(", x-frame-options:")[0].toString();
    }
    else{
      return "";
    }
  }
  Future<String> _loginSystemPost(String tokenKey, String userName, String password) async{
    Map<String, String> requestHeaders = {
      //'Content-type': 'application/json',
      //'Accept': 'application/json',
      'Authorization': '$tokenKey'
    };

    String url = "http://103.226.250.13:7001/NSSC-API-Sys/authenticationUser?userCode=$userName&userPassword=$password";
    print(url);
    final response = await http.get(url, headers: requestHeaders);
    print(response.statusCode);
    print(tokenKey);
    print(requestHeaders);
    if(response.statusCode == 200){
      return "OK";
    }
    else{
      return "NO";
    }
  }
  void Login(String tokenKey, String userName, String password){
    Future<String> futureLoginSystem = _loginSystemPost(tokenKey, controllerUser.text, controllerPassword.text);
    futureLoginSystem.then((value) => {
      print(value),
      if(value == "OK"){
        Navigator.pop(context, tokenKey)
      }
      else{
        animated_dialog_box.showScaleAlertBox(
            title:Center(child: Text("Login")) , // IF YOU WANT TO ADD
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
              child: Text('Login failed. Please try again!'),
            ))
      }

    });
  }
}
