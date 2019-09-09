import 'package:ecommerce_test/models/AllTransactionListModel.dart';
import 'package:ecommerce_test/models/balance_model.dart';
import 'package:ecommerce_test/models/detail_transaction_model.dart';
import 'package:ecommerce_test/models/login_model.dart';
import 'package:ecommerce_test/models/transaction_history_model.dart';
import 'package:ecommerce_test/models/transaction_response.dart';
import 'package:ecommerce_test/util/shared_preference.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static Future getDataItem() {
    return http.get(
        'http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,AR.vm?cmd=1&custid=DM152204830857645176904');

//    if (response.statusCode == 200) {
//      List responseJson = await json.decode(response.body);
//      final data =
//      responseJson.map((m) => new TransactionHistoryModel.fromJson(m)).toList();
//      return responseJson ;
//    }
  }

  static Future<String> changeAddress(
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

    return response.body ;
  }


 static Future<List<DetailTransactionModel>> getDetailTransaction() async {
    http.Response response;
    String _baseUrl =
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,SPGApps.vm?cmd=4&txtype=SO_DETAIL&txno=DM141481151763163039543";

    response = await http.get(
        '$_baseUrl');

    var  responseJson = await json.decode(response.body);

    final List<DetailTransactionModel> data = responseJson
        .map((md) => DetailTransactionModel.fromJson(md))
        .toList();

    return data;
  }



  static getArBalance(String custId) async {

    http.Response response;
    String _baseUrl =
        'http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,AR.vm?cmd=2&custid=DM152204830857645176904';

    response = await http.get(_baseUrl);

    List responseJson = await json.decode(response.body);
    final data = responseJson
        .map((md) => new BalanceModel.fromJson(md))
        .toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user_ar",double.parse(data[0].arBalance).toStringAsFixed(0).toString());
  }

  static Future<TransactionResponse> getDataTransaction() async {
    Map<String, dynamic> mapResponse;
    var uri = Uri.parse(
        'http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,CreateSI.vm');
    var request = new http.MultipartRequest("POST", uri);
    request.fields["docs"] =
        '{"sales_trans":[{"trans_no":"POS-M01\/1802\/01456","trans_type":"SO","location":"GODM","trans_dt":"24\/10\/2018","customer":"DM156635366873800051904","create_by":"m0101","remark":"","pmttype":"","pmtterm":"","details":[{"item_code":"0118001","item_id":"DM141425265601900852163","qty":"1","unit":"PCS","price":"80000.0","tax":"","discount":"0.0%"}]}]}';

    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      mapResponse = json.decode(value);
    });
    return TransactionResponse.fromJson(mapResponse);
  }

  static Future<List<TransactionHistoryModel>> getTransactionHistoryData(
      String userId) async {
    http.Response response;
    response = await http.get(
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,AR.vm?cmd=1&custid=$userId");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

      List responseJson = await json.decode(response.body);

      final data = responseJson
          .map((md) => new TransactionHistoryModel.fromJson(md))
          .toList();
      return data.cast();
    } else {
      return null;
    }
  }

  static Future<List<AllTransactionListModel>> getAllTransactionModel(
      String userId) async {
    print(userId);
    http.Response response;
    response = await http.get(
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,SPGApps.vm?cmd=4&custcode=$userId");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

      List responseJson = await json.decode(response.body);

      final data = responseJson
          .map((md) => new AllTransactionListModel.fromJson(md))
          .toList();
      return data.cast();
    } else {
      return null;
    }
  }
}
