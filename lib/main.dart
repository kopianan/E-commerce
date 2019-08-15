import 'package:ecommerce_test/util/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'layouts/master_pages/home.dart';
import 'layouts/master_pages/login.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasUserData = false;

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  void _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String userData = "";
    userData = prefs.getString('userFullname');

    try {
      SharedPreference localData;
      User userLocalData = localData.getUserData() as User;
      print(userLocalData.fullName);
    } catch (Exception) {}

    setState(() {
      if (userData == "andy lianto") {
        hasUserData = true;
      } else {
        hasUserData = false;
      }
    });
    print(prefs.getString('userFullname'));
  }

  @override
  Widget build(BuildContext context) {
    print(hasUserData);
    return MaterialApp(
      title: 'Navigation Basics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: hasUserData ? Home() : Login(),
    );
  }
}
