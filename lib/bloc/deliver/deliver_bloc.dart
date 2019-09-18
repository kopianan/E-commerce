import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_test/models/CityModel.dart';
import 'package:ecommerce_test/models/check_onkir_model.dart';
import 'package:ecommerce_test/models/list_of_ongkir_model.dart';
import 'deliver_event.dart';
import 'deliver_state.dart';
import 'package:http/http.dart' as http;

class DeliverBloc extends Bloc<DeliverEvent, DeliverState> {
  @override
  DeliverState get initialState => InitialDeliverState();

  @override
  Stream<DeliverState> mapEventToState(
    DeliverEvent event,
  ) async* {
    if (event is GetAllPriceOfDeliver) {
      yield GetAllDeliverPriceLoading();
      final listOngkir = await _getAllListOngkir(
          event.weight, event.origin, event.destination);
      if (listOngkir.length == 0) {
        yield GetAllDeliverPriceFailed("Empty");
      } else {
        yield GetAllDeliverPriceSuccess(listOngkir);
      }
    }

    if(event is GetAllProvinceAndCity){
      yield GetAllProvinceAndCityLoading();
      final listProvinceAndCity = await _getAllProvinceAndCity() ;
      if(listProvinceAndCity == null || listProvinceAndCity.rajaongkir.results.length == 0){
        yield GetAllProvinceAndCityFailed("Empty");
      }else{
        yield GetAllProvinceAndCitySuccess(listProvinceAndCity);
      }
    }
  }
  ///get all list ongkir (JNE DAN TIKI) by input weight, originsID and destinationID
  Future<List<ListOfOngkirModel>> _getAllListOngkir(
      int weight, int origins, int destination) async {
    List<CheckOngkirModel> finalResponse = List<CheckOngkirModel>();
    List<ListOfOngkirModel> listOngkir = List<ListOfOngkirModel>();
    origins = 10;

    Map<String, String> headers = {"Content-type": "application/json"};
    final List<String> listPengiriman = ["jne", "tiki"];
    final String _baseurl = "https://api.rajaongkir.com/starter/cost";
    List<http.Response> list = await Future.wait(listPengiriman.map((courier) =>
        http.post(_baseurl,
            body:
                '{"key" : "e1eedfd1a43f04a99122dbcc2f4a0291","origin": $origins,"destination" :$destination,"weight" :$weight,"courier"  : "$courier"}',
            headers: headers)));
    list.map((response) {
      finalResponse.add(CheckOngkirModel.fromJson(jsonDecode(response.body)));
    }).toList();
    finalResponse.map((obj) {
      obj.rajaongkir.results.map((cost) {
        cost.costs.map((costs) {
          costs.cost.map((c) {
            listOngkir.add(ListOfOngkirModel(
                price: c.value.toString(),
                etd: c.etd,
                name: cost.name,
                service: costs.service));
          }).toList();
        }).toList();
      }).toList();
    }).toList();

    return listOngkir;
  }
}


Future<CityModel> _getAllProvinceAndCity() async {
  http.Response response;
  response = await http.get(
      'https://api.rajaongkir.com/starter/city?key=e1eedfd1a43f04a99122dbcc2f4a0291');

  var responseJson = await json.decode(response.body);

  final data = CityModel.fromJson(responseJson);
  return data ;
}
