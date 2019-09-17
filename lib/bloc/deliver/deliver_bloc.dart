import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
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
  }

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
