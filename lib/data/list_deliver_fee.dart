import 'dart:convert';

import 'package:ecommerce_test/models/check_onkir_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ListDeliverFee extends ChangeNotifier {
  List<CheckOngkirModel> listOfOngkir = List<CheckOngkirModel>();
  String jneReg = "";
  String jneOke = "";
  String tiki = "";
  int selected = 10;

  ListDeliverFee() {}

  ListDeliverFee clearSelected (int select) {
    this.selected = select;
    notifyListeners();
  }

  void setSelectedRadion(int val) {
    selected = val;
    notifyListeners();
  }

  void setJneReg(String service, String val, String etd) {
    jneReg = service + " " + val + " ($etd hari)";
    notifyListeners();
  }

  void setJneOke(String service, String val, String etd) {
    jneOke = service + " " + val + " ($etd hari)";
    notifyListeners();
  }

  void setTiki(String service, String val, String etd) {
    tiki = service + " " + val + " ($etd hari)";
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

   int getSubTotalOngkir(int weight){
    int mWeight = weight;

    if(selected <= 1){
      if(selected == 0){
        print(int.parse(listOfOngkir[0].rajaongkir.results[0].costs[1].cost[0].value.toInt().toString()));
        return mWeight * int.parse(listOfOngkir[0].rajaongkir.results[0].costs[1].cost[0].value.toInt().toStringAsFixed(0));
      }else if (selected == 1){
        return mWeight * int.parse(listOfOngkir[0].rajaongkir.results[0].costs[0].cost[0].value.toInt().toStringAsFixed(0));
      }
    }else if(selected == 2){
      return mWeight * int.parse(listOfOngkir[1].rajaongkir.results[0].costs[0].cost[0].value.toInt().toStringAsFixed(0));
    }else{
      return 0;
    }

  }

  void multipleRequest(int weight) async {

    Map<String, String> headers = {"Content-type": "application/json"};
    final List<String> listPengiriman = ["jne", "tiki"];
    final String _baseurl = "https://api.rajaongkir.com/starter/cost";
    List<http.Response> list = await Future.wait(listPengiriman.map((courier) =>
        http.post(_baseurl,
            body:
                '{"key" : "e1eedfd1a43f04a99122dbcc2f4a0291","origin": "10","destination" : "20","weight" :$weight,"courier"  : "$courier"}',
            headers: headers)));
    clearListOfOngkir();
    List<CheckOngkirModel> finalResponse = list.map((response) {
      addItemToListOngkir(CheckOngkirModel.fromJson(jsonDecode(response.body)));
    }).toList();


    setJneReg(
        listOfOngkir[0].rajaongkir.results[0].costs[1].service,
        listOfOngkir[0].rajaongkir.results[0].costs[1].cost[0].value.toString(),
        listOfOngkir[0].rajaongkir.results[0].costs[1].cost[0].etd);
    setJneOke(
        listOfOngkir[0].rajaongkir.results[0].costs[0].service,
        listOfOngkir[0].rajaongkir.results[0].costs[0].cost[0].value.toString(),
        listOfOngkir[0].rajaongkir.results[0].costs[0].cost[0].etd);
    setTiki(
        listOfOngkir[1].rajaongkir.results[0].costs[0].service,
        listOfOngkir[1].rajaongkir.results[0].costs[0].cost[0].value.toString(),
        listOfOngkir[1].rajaongkir.results[0].costs[0].cost[0].etd);
  }
}
