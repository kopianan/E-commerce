import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_test/bloc/payment/payment_payment_event.dart';
import 'package:ecommerce_test/bloc/payment/payment_payment_state.dart';
import 'package:ecommerce_test/models/balance_model.dart';
import 'package:ecommerce_test/util/shared_preference.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PaymentPaymentBloc
    extends Bloc<PaymentPaymentEvent, PaymentPaymentState> {
  SharedPreference prefs = SharedPreference();

  @override
  PaymentPaymentState get initialState => InitialPaymentPaymentState();

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

  if(event is GetArBalanceAsync){

    yield GetArBalanceLoading();
      final String balance = await _getArBalance(event.userId);

    if(balance == "" || balance == null){
      yield GetArBalanceFailed("Empty") ;
    }else{
      yield GetArBalanceSuccess(balance);
    }
  }

    }
  }

Future<String> _getArBalance(String custId) async {
  http.Response response;
  String _baseUrl =
      'http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,AR.vm?cmd=2&custid=$custId';

  response = await http.get(_baseUrl);
  List responseJson = await json.decode(response.body);
  final data =
  responseJson.map((md) => new BalanceModel.fromJson(md)).toList();

  print(response.body);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String dataArString = data.first.arBalance;
  String Ar = "";


  if (dataArString.contains("-")) {
    Ar = dataArString.substring(1, dataArString.length);
  } else {
    Ar = "-" + dataArString;
  }
  prefs.setString("user_ar", double.parse(Ar).toStringAsFixed(0).toString());

  return Ar ;
}

