import 'dart:convert';

import 'package:ecommerce_test/layouts/master_pages/my_order.dart';
import 'package:ecommerce_test/layouts/master_pages/transaction_list.dart';
import 'package:ecommerce_test/layouts/master_pages/profile.dart';
import 'package:ecommerce_test/layouts/pages/cart_page.dart';
import 'package:ecommerce_test/models/tukar_point.dart';
import 'package:ecommerce_test/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageMe extends StatefulWidget {
  @override
  _PageMeState createState() => _PageMeState();
}

class _PageMeState extends State<PageMe> {
String userFullname;
User localUser  ;

@override
void initState() {
  super.initState();
    getUserData();
  }

getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User user =  User.fromJson(json.decode(prefs.getString("user_data")));
  localUser = user ;

  print(prefs.getString("user_data"));
}


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Color.fromARGB(255, 49, 49, 49),
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
                    userFullname == null ? '-' : userFullname,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
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
                            "Point",
                            style: TextStyle(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            "4500",
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
            width: double.infinity,
            child: RaisedButton(
              color: Colors.white,
              splashColor: Colors.yellow,
              padding: const EdgeInsets.all(20),
              child: Container(child: Text("Profile Saya")),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              color: Colors.white,
              splashColor: Colors.yellow,
              padding: const EdgeInsets.all(20),
              child: Container(child: Text("Daftar Transaksi")),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartPage()));
              },
            ),
          ),
        Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.white,
                splashColor: Colors.yellow,
                padding: const EdgeInsets.all(20),
                child: Container(child: Text("Belanjaan Saya")),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyOrder()));
                },
              ),
            ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              color: Colors.white,
              splashColor: Colors.yellow,
              padding: const EdgeInsets.all(20),
              child: Container(child: Text("Tukar Poin")),
              onPressed: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TukarPoint()));
              },
            ),
          )
        ],
      ),
    );
  }
}
