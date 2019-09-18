import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BackendService {
  static Future<List<DataItemModel>> getDataItem(offset , limit) async {
    http.Response response;
    response = await http.get(
        'http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,SPGApps.vm?cmd=2&loccode=GODM&limit=$limit&offset=$offset');

    if (response.statusCode == 200) {
      List responseJson = await json.decode(response.body);
      final data =
          responseJson.map((m) => new DataItemModel.fromJson(m)).toList();
      return data.cast();
    } else {
      return null;
    }
  }
}
