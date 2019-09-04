import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_test/bloc/payment/payment_payment_event.dart';
import 'package:ecommerce_test/bloc/payment/payment_payment_state.dart';
import 'package:ecommerce_test/models/check_onkir_model.dart';
import 'package:ecommerce_test/models/chekc_ongkir_request.dart';
import 'package:http/http.dart' as http;

class PaymentPaymentBloc
    extends Bloc<PaymentPaymentEvent, PaymentPaymentState> {
  @override
  PaymentPaymentState get initialState => InitialPaymentPaymentState();

  final String _baseurl = "https://api.rajaongkir.com/starter/cost";
  final String keyString = "e1eedfd1a43f04a99122dbcc2f4a0291";

  @override
  Stream<PaymentPaymentState> mapEventToState(
    PaymentPaymentEvent event,
  ) async* {
//    if (event is GetDeliverFee) {
//      yield GetPriceFeeLoading();
//
//      CheckOngkirRequest check = CheckOngkirRequest(
//          courier: "jne",
//          destination: "10",
//          origin: "20",
//          weight: 1000,
//          key: "e1eedfd1a43f04a99122dbcc2f4a0291");
//
//      final checkOngkirModel =
//          await _getPriceAsync(_baseurl, body: check.toJson());
//
//      print(checkOngkirModel.toJson().toString());

    }
  }


Future<CheckOngkirModel> _getPriceAsync(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return CheckOngkirModel.fromJson(json.decode(response.body));
  });
}
