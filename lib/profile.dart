import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';

class Profile extends StatelessWidget {
  String userFullname;
String userEmail;
String userBirthDate;
String userName;

  getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = User.fromJsonError(json.decode(prefs.getString("user_data")));
  userFullname = user.fullName;
  userEmail = user.email;
  userBirthDate = userBirthDate;
  userName = user.userName;
}
  @override
  Widget build(BuildContext context) {
    getUserData();
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
        title: Text(""),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.yellow,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 10.0),
              child: Text(
                "EDIT",
                style: TextStyle(
                    color: Colors.yellow, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: new BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                      border:
                          new Border.all(width: 2.5, color: Colors.deepPurple)),
                ),
                Container(
                  child: Text(
                    userFullname,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.yellow,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          child: Text("TOTAL SALDO")),
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Rp 125.000,-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.deepPurple,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            "DATA",
                            style: TextStyle(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Rp 4.500,-",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          
          
          Container(
            padding: EdgeInsets.all(25),
            color: Colors.white70,
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Date of Birth",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
                Expanded(
                  child: Text(
                    userBirthDate,
                    textAlign: TextAlign.end,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(25),
            color: Colors.white70,
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Full Name",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
                Expanded(
                  child: Text(
                    userFullname,
                    textAlign: TextAlign.end,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(25),
            color: Colors.white70,
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Email",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
                Expanded(
                  child: Text(
                    userEmail,
                    textAlign: TextAlign.end,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(25),
            color: Colors.white70,
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Username",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
                Expanded(
                  child: Text(
                    userName,
                    textAlign: TextAlign.end,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(25),
            color: Colors.white70,
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Password",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Ubah Kata Sandi",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.yellow),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
          ),
        ],
      ),
    ));
  }
}
