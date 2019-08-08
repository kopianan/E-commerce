import 'dart:convert';

import 'package:ecommerce_test/models/login_model.dart';
import 'package:flutter/material.dart' ;
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart'; 
import 'package:http/http.dart' as http;

import '../home.dart';
import '../register.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  Future<LoginModel> loginAsync() async {
    http.Response response;
    response = await http.get(
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,User.vm?method=login&email=andy@gmail.com&password=123");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

      final data = LoginModel.fromJson(json.decode(response.body));
      if (data.userId != "") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 238, 238, 238),
        body: Container(
          margin: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/LOGO.png'),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Email / Username ",
                      labelStyle: TextStyle(
                          color: Colors.purple, fontStyle: FontStyle.italic),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.blue))),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Password ",
                      labelStyle: TextStyle(
                          color: Colors.purple, fontStyle: FontStyle.italic),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.blue))),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      "Forgot Password ?   ",
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.purple),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "click here",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            color: Colors.purple,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        onPressed: () async {
                          loginAsync();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Home()),
                          // );
                        },
                        color: Color.fromARGB(255, 130, 39, 74),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Text(
                  'or login by',
                  style: TextStyle(color: Color.fromARGB(255, 130, 39, 74)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FacebookSignInButton(onPressed: () {}),
                    GoogleSignInButton(onPressed: () {}, darkMode: true),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Text(
                  'Doesn\'t have account?',
                  style: TextStyle(color: Color.fromARGB(255, 130, 39, 74)),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  color: Color.fromARGB(255, 130, 39, 74),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Register NOW!",
                    style: TextStyle(color: Colors.yellowAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
