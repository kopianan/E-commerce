import 'dart:convert';

import 'package:ecommerce_test/models/check_onkir_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ListDeliverFee extends ChangeNotifier {
  String jne = "";
  String tiki = "";

  void setJnePrice(String jne) {
    this.jne = jne;
    notifyListeners();
  }

  void setTikiPrice(String tiki) {
    this.tiki = tiki;
    notifyListeners();
  }

  void multipleRequest() async {
    Map<String, String> headers = {"Content-type": "application/json"};
    final List<String> listPengiriman = ["jne", "tiki"];
    final String _baseurl = "https://api.rajaongkir.com/starter/cost";
    List<http.Response> list =
        await Future.wait(listPengiriman.map((courier) => http.post(
            _baseurl,
            body:  '{"key" : "e1eedfd1a43f04a99122dbcc2f4a0291","origin": "10","destination" : "20","weight" : 1000,"courier"  : "$courier"}',
            headers: headers)));

    final finalResponse =  list.map((response) {
      print(response.body);
      return new CheckOngkirModel();
    }).toList();

    print(finalResponse[0].rajaongkir.destinationDetails);
    print(finalResponse[1].rajaongkir.destinationDetails);
}

  void getPaymentTypeRequest() async {
    final String _baseurl = "https://api.rajaongkir.com/starter/cost";
    final List<String> listPengiriman = ["jne", "tiki"];

    Map<String, String> headers = {"Content-type": "application/json"};

    // make POST request
    listPengiriman.forEach((it) async {
      String requestJne =
          '{"key" : "e1eedfd1a43f04a99122dbcc2f4a0291","origin": "10","destination" : "20","weight" : 1000,"courier" : "${it.toString()}"}';

      http.Response response =
          await http.post(_baseurl, headers: headers, body: requestJne);
      Map jsonResult = await jsonDecode(response.body);
      var ongkir = CheckOngkirModel.fromJson(jsonResult);

      if (it.toString() == "jne") {
        setJnePrice(
            ongkir.rajaongkir.results[0].costs[0].cost[0].value.toString());
      } else if (it.toString() == "tiki") {
        setTikiPrice(
            ongkir.rajaongkir.results[0].costs[0].cost[0].value.toString());
      }
    });
  }
}
