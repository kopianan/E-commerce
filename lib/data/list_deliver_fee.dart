import 'dart:convert';

import 'package:ecommerce_test/models/CityModel.dart';
import 'package:ecommerce_test/models/CityModel.dart' as prefix0;
import 'package:ecommerce_test/models/check_onkir_model.dart';
import 'package:ecommerce_test/models/list_of_ongkir_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ListDeliverFee extends ChangeNotifier {
  List<CheckOngkirModel> listOfOngkir = List<CheckOngkirModel>();
  ///the data is filled after user click choose ongkos kirim
  List<prefix0.Results> procitymodel = List<prefix0.Results>();

  int selected = 10;
  int totalWeight = 0;
  ///List data ongkir yang berisi harga, jenis pengiriman dan jumlah hari [ListOfOngkirModel]
  List<ListOfOngkirModel> listOngkir = List<ListOfOngkirModel>();
  ListOfOngkirModel selectedOngkir = ListOfOngkirModel();

  ListDeliverFee() {}

  void clearSelectedOngkir(){
    listOngkir.clear();
    selected = -1 ;
    selectedOngkir=null ;
    notifyListeners();
  }
  void setSelectedOngkir(int index) {
    selectedOngkir = listOngkir[index];
    notifyListeners();
  }

  ///function untuk set list ongkir yang telah. data list di dapat dari origins, destination dan weight yg telah di inputkan
  void setListOngkirDataList(List<ListOfOngkirModel> list){

    list.forEach((it){
      var modifyName =it.name.split("(").last.toString();
      it.name =modifyName.substring(0, modifyName.length-1);
    });
    listOngkir = list ;
    notifyListeners();
  }

  void addListOngkir(ListOfOngkirModel data) {
    listOngkir.add(data);
    notifyListeners();
  }

  void clearListOngkir() {
    listOngkir.clear();
    notifyListeners();
  }

  ListDeliverFee clearSelected(int select) {
    this.selected = select;
    notifyListeners();
  }

  void setSelectedRadion(int val) {
    selected = val;
    notifyListeners();
  }

  void addItemToListOngkir(CheckOngkirModel ongkir) {
    listOfOngkir.add(ongkir);
    notifyListeners();
  }

  void clearListOfOngkir() {
    listOfOngkir.clear();
    listOngkir.clear();
    notifyListeners();
  }

  void setProCityModel(List<prefix0.Results> res){
    procitymodel = res ;
    notifyListeners();
  }


  String sumTotalOngkosKirim(int weight) {
    if(selectedOngkir.price == null ){
      return "0";
    }else {
      return (weight * int.parse(selectedOngkir.price)).toString();
    }
  }

  var name = "";
  var service = "";
  var harga = "";


  ///Get City ID By City Name.
   int getCityIdByTypeAndCityName(String cityName)  {
    String cityId = "";
    procitymodel.map((obj)  {
      if ( obj.type + " " + obj.cityName== cityName) {
        cityId = obj.cityId;
      }
    }).toList();
    return int.parse(cityId);

  }


}
