import 'dart:convert';

import 'package:ecommerce_test/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{

  final String USER_DATA_PREFERENCE = "user_data_preference";

  void saveUserData(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = user.toJson().toString();
    await prefs.setString(USER_DATA_PREFERENCE, userJson);
  }

  Future<User> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefsValue =  prefs.getString(USER_DATA_PREFERENCE);
    User userData = User.fromJson(json.decode(prefsValue));
    return userData;
  }

}