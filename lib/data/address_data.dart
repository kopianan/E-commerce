import 'dart:convert';

import 'package:ecommerce_test/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:ecommerce_test/models/province_model.dart' as province;
import 'package:ecommerce_test/models/CityModel.dart' as city;
import 'package:shared_preferences/shared_preferences.dart';


class AddressData extends ChangeNotifier {
  List<province.Results> listOfResult = List<province.Results>();
  List<city.Results> listOfCity = List<city.Results>();
  LoginModel userData = LoginModel();

  String nama;
  String noHp;
  String alamat;

  String cityName = "";

  String provinceName = "";

  String provinceId;

  String cityId;

  void setUserData(LoginModel loginModel) {
    userData = loginModel;
    notifyListeners();
  }

  String getUserDataCityName(){
    return userData.city;
  }

  void setCity(String cityId, String cityName) {
    this.cityId = cityId;
    this.cityName = cityName;
    notifyListeners();
  }

  void setProvince(String prov, String provName) {
    provinceId = prov;
    provinceName = provName;
    notifyListeners();
  }

  void setListOfProvince(List<province.Results> list) {
    listOfResult = list;
    notifyListeners();
  }

  void setListOfCity(List<city.Results> list) {
    listOfCity = list;
    notifyListeners();
  }



  getChangedAddress(
      String email, String province, String city, String address) async {
    http.Response response;
    String _baseUrl =
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/";

    response = await http.get(
        '${_baseUrl}api,User.vm?method=saveProfile&email=${email}&province=${province}&city=${city}&address=${address}&tocust=true');

    var responseJson = await json.decode(response.body);

    final data = LoginModel.fromJson(responseJson);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user_data", response.body);
    setUserData(data);
  }


  void getUserDataInPrference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginModel user =
        LoginModel.fromJson(json.decode(prefs.getString("user_data")));
    userData = user;
    notifyListeners();
  }


}
