import 'dart:convert';

import 'package:ecommerce_test/layouts/master_pages/home.dart';
import 'package:ecommerce_test/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _obscureText = true;
  String oldPassword;
  String newPassword;
  String confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "Ubah Password",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (val) {
                  oldPassword = val;
                },
                autofocus: false,
                obscureText: _obscureText,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Old Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      semanticLabel:
                          _obscureText ? 'show password' : 'hide password',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (val) {
                  newPassword = val;
                },
                autofocus: false,
                obscureText: _obscureText,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'New Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      semanticLabel:
                          _obscureText ? 'show password' : 'hide password',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (val) {
                  confirmPassword = val;
                },
                autofocus: false,
                obscureText: _obscureText,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Confirmation Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      semanticLabel:
                          _obscureText ? 'show password' : 'hide password',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  child: Text(
                    "Ubah Password",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  color: Colors.amber,
                  onPressed: () {
                    if (confirmPassword == newPassword) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ShowDialog(oldPassword, newPassword);
                          });
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShowDialog extends StatelessWidget {
  final String old;
  final String newP;

  ShowDialog(this.old, this.newP);

  Future<LoginModel> changePassword(String email, String password) async {
    http.Response response;
    String _baseUrl =
        'http://datacloud.erp.web.id:8081/padadev18/weblayer/template';
    response = await http.get(
        '$_baseUrl/api,User.vm?method=changePassword&email=alfred@gmail.com&oldpass=$old&newpass=$newP');

    if (response.statusCode == 200) {
      // If the callto the server was successful, parse the JSON
      try {
        final user = LoginModel.fromJson(json.decode(response.body));
        return user;
      } catch (Exception) {
        final user = LoginModel.fromJson(json.decode(response.body));
        return user;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: changePassword(old, newP),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.active:
            case ConnectionState.done:
              if(snapshot.data.toString().contains("1"))
              return AlertDialog(
                title: Icon(Icons.error, color: Colors.red,size: 90,),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Gagal Ubah Password", style: TextStyle(fontSize: 20),),
                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: Colors.amber,
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text("OK", style: TextStyle(color: Colors.black, ),),
                      ),
                    )
                  ],
                ),
              );
              else{
                return AlertDialog(
                  title: Icon(Icons.check_box, color: Colors.green,size: 90,),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Berhasil Ubah Password", style: TextStyle(fontSize: 20),),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          color: Colors.amber,
                          onPressed: (){
                            Navigator.push(
                                context,
                                 MaterialPageRoute(
                                    builder: (BuildContext context) => Home()));
                          },
                          child: Text("OK", style: TextStyle(color: Colors.black, ),),
                        ),
                      )
                    ],
                  ),
                );
              }
          }
          return Text("GAKS");
        },
      ),
    );
  }
}
