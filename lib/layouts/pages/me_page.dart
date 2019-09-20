import 'dart:convert';
import 'package:ecommerce_test/data/api_service.dart';
import 'package:ecommerce_test/layouts/master_pages/my_order.dart';
import 'package:ecommerce_test/layouts/master_pages/profile.dart';
import 'package:ecommerce_test/layouts/pages/cart_page.dart';
import 'package:ecommerce_test/models/login_model.dart';
import 'package:ecommerce_test/models/tukar_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageMe extends StatefulWidget {
  @override
  _PageMeState createState() => _PageMeState();
}

class _PageMeState extends State<PageMe> {
  String userFullname;
  LoginModel localUser;

  String Ar;
  String pointUser ;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginModel user =
        LoginModel.fromJson(json.decode(prefs.getString("user_data")));
    localUser = user;

   await ApiService.getArBalance(localUser.userId);
   await ApiService.getPoint(localUser.userId);

    setState(() {
      Ar = prefs.getString("user_ar");
      pointUser = prefs.getString("user_point");
    });
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
                    (localUser== null )? '-' : localUser.fullName,
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
                  width: MediaQuery.of(context).size.width / 3,
                  color: Colors.yellow,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          child: Text("TOTAL SALDO")),
                      Container(
                          alignment: Alignment.center,
                          child: (Ar == "null" || Ar == null)
                              ? Container(child:CircularProgressIndicator() ,height: 15,width: 15,)
                              : Text(
                                  'Rp. $Ar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
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
                          child: (pointUser == "null" || pointUser == null)
                              ? Container(child:CircularProgressIndicator() ,height: 15,width: 15,)
                              : Text(
                            '$pointUser',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  color: Colors.black54,
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartPage()));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyOrder()));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TukarPoint()));
              },
            ),
          )
        ],
      ),
    );
  }
}
