import 'dart:convert';

import 'package:ecommerce_test/models/CityModel.dart';
import 'package:ecommerce_test/models/CityModel.dart' as prefix0;
import 'package:ecommerce_test/models/check_onkir_model.dart';
import 'package:ecommerce_test/models/list_of_ongkir_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ListDeliverFee extends ChangeNotifier {
  List<CheckOngkirModel> listOfOngkir = List<CheckOngkirModel>();
  List<prefix0.Results> procitymodel = List<prefix0.Results>();

  int selected = 10;
  int totalWeight = 0;

  List<ListOfOngkirModel> listOngkir = List<ListOfOngkirModel>();
  ListOfOngkirModel selectedOngkir = ListOfOngkirModel();

  ListDeliverFee() {}

  void setSelectedOngkir(int index) {
    selectedOngkir = listOngkir[index];
    notifyListeners();
  }

  void setListOngkirDataList(List<ListOfOngkirModel> list){
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


  void getAllProvinceAndCity() async {
    http.Response response;
    response = await http.get(
        'https://api.rajaongkir.com/starter/city?key=e1eedfd1a43f04a99122dbcc2f4a0291');

    var responseJson = await json.decode(response.body);

    final data = CityModel.fromJson(responseJson);
    setProCityModel(data.rajaongkir.results);

  }

  getProvinceIdFromList(String provinceName) async {
    String provId;
    procitymodel.map((obj) {
      if (obj.type + " " + obj.cityName == provinceName) {
        provId = obj.cityId;
      }else{
        provId = "20" ;
      }
    }).toList();
    print(provId);
    return provId;

  }

  void multipleRequest(int weight, int destination) async {
    List<CheckOngkirModel> finalResponse = List<CheckOngkirModel>();
    Map<String, String> headers = {"Content-type": "application/json"};
    final List<String> listPengiriman = ["jne", "tiki"];
    final String _baseurl = "https://api.rajaongkir.com/starter/cost";
    List<http.Response> list = await Future.wait(listPengiriman.map((courier) =>
        http.post(_baseurl,
            body:
                '{"key" : "e1eedfd1a43f04a99122dbcc2f4a0291","origin": 10,"destination" :$destination,"weight" :$weight,"courier"  : "$courier"}',
            headers: headers)));
    clearListOfOngkir();

    list.map((response) {
      finalResponse.add(CheckOngkirModel.fromJson(jsonDecode(response.body)));
      addItemToListOngkir(CheckOngkirModel.fromJson(jsonDecode(response.body)));
    }).toList();
    clearListOngkir();
    finalResponse.map((obj) {
      obj.rajaongkir.results.map((cost) {
        this.name = cost.name;
        cost.costs.map((costs) {
          this.service = costs.service;
          costs.cost.map((c) {
            listOngkir.add(ListOfOngkirModel(
                price: c.value.toString(),
                etd: c.etd,
                name: this.name,
                service: this.service));
          }).toList();
        }).toList();
      }).toList();
    }).toList();
  }
}
