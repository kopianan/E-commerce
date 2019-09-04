import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:ecommerce_test/models/province_model.dart' as province;
import 'package:ecommerce_test/models/CityModel.dart' as city;

class AddressData extends ChangeNotifier {
  List<province.Results> listOfResult = List<province.Results>();
  List<city.Results> listOfCity = List<city.Results>();
  String nama;
  String noHp;
  String alamat;

  String cityName ="" ;
  String provinceName="" ;
  String provinceId ;
  String cityId ;

  void setCity(String cityId , String cityName){
    this.cityId = cityId;
    this.cityName = cityName;
    notifyListeners();
  }

  void setProvince(String prov, String provName){
    provinceId = prov;
    provinceName = provName ;
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

  getCityData(String val) async {
    var _baseUrl =
        "https://api.rajaongkir.com/starter/city?key=e1eedfd1a43f04a99122dbcc2f4a0291&province=$val";

    var res = await http.get(_baseUrl);
    var resBody = json.decode(res.body);

    var test = city.CityModel.fromJson(resBody);
    setListOfCity(test.rajaongkir.results);
  }

  getProvinceData() async {
    var _baseUrl = "https://api.rajaongkir.com/starter/province";

    var res = await http
        .get(_baseUrl, headers: {"key": "e1eedfd1a43f04a99122dbcc2f4a0291"});
    var resBody = json.decode(res.body);

    var test = province.ProvinceModel.fromJson(resBody);
    setListOfProvince(test.rajaongkir.results);
  }
}
