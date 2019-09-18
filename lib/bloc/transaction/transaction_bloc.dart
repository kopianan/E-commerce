import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_test/bloc/transaction/transaction_event.dart';
import 'package:ecommerce_test/bloc/transaction/transaction_state.dart';
import 'package:ecommerce_test/models/transaction_response.dart';
import 'package:http/http.dart' as http;


class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  @override
  TransactionState get initialState => TransactionInitial();

  @override
  Stream<TransactionState> mapEventToState(
    TransactionEvent event,
  ) async* {
    if(event is DoTransaction){
      yield TransactionLoading();
      final trans = await _makeTransaction(event.url);
      if(trans.error == 1){
        //showErrorMessage by typeing trans.message
        yield TransactionFailed(trans.message);
      }else if (trans.error == 0){
        yield TransactionSuccess(trans);
      }

    }
  }
}


Future<TransactionResponse> _makeTransaction(String jsonDocs) async {
  var uri = Uri.parse(
      'http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,CreateSI.vm');
  var request = new http.MultipartRequest("POST", uri);

//  request.fields["docs"] = '{"sales_trans":[{"trans_no":"POS-M01\/1802\/01456","trans_type":"SO","location":"GODM","trans_dt":"24\/10\/2018","customer":"DM156635366873800051904","create_by":"m0101","remark":"","pmttype":"","pmtterm":"","details":[{"item_code":"0118001","item_id":"DM141425265601900852163","qty":"1","unit":"PCS","price":"80000.0","tax":"","discount":"0.0%"}]}]}';
  request.fields["docs"] =
  '{"sales_trans":[{"trans_no":"POS-M01\/1802\/01456","trans_type":"SO","location":"GODM","trans_dt":"24\/10\/2018","customer":"DM156635366873800051904","create_by":"m0101","remark":"","pmttype":"","pmtterm":"","details":[{"item_code":"0118001","item_id":"DM141425265601900852163","qty":"1","unit":"PCS","price":"80000.0","tax":"","discount":"0.0%"}]}]}';

  var response = await request.send();
  if (response.statusCode == 200) {
    response.stream.transform(utf8.decoder).listen((value) {
      final decoded = TransactionResponse.fromJson(jsonDecode(value));
      return decoded;
    });
  } else {
    return null;
  }
}
