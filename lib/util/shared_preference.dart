import 'dart:convert';

import 'package:ecommerce_test/models/login_model.dart';
import 'package:ecommerce_test/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{

  final String USER_DATA_PREFERENCE = "user_data_preference";
  final String COMPLETE_USER_DATA_PREFERENCE = "complete_user_data_preference";

  void saveUserData(LoginModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = user.toJson().toString();
    await prefs.setString(USER_DATA_PREFERENCE, userJson);
  }
  void clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(USER_DATA_PREFERENCE, "");
  }

  Future<LoginModel> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefsValue =  prefs.getString(USER_DATA_PREFERENCE);
    LoginModel userData = LoginModel.fromJson(json.decode(prefsValue));
    return userData;
  }

}