import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_test/layouts/master_pages/my_order.dart';
import 'package:ecommerce_test/models/sales_transaction_model.dart';
import 'package:ecommerce_test/models/transaction_response.dart';
import 'package:flutter/material.dart';

class PaymentSuccess extends StatefulWidget {
  final SalesTransactionModel data;

  PaymentSuccess({@required this.data});

  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  Future<TransactionResponse> _dioTransaction() async {
    Dio dio = new Dio();
    dio.options.baseUrl =
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,CreateSI.vm";
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 30000;
//      FormData formData = new FormData.from({
//        "docs": '{"sales_trans":[{"trans_no":"POS-M01\/1802\/01456","trans_type":"SO","location":"GODM","trans_dt":"24\/10\/2018","customer":"DM156635366873800051904","create_by":"m0101","remark":"","pmttype":"","pmtterm":"","details":[{"item_code":"0118001","item_id":"DM141425265601900852163","qty":"1","unit":"PCS","price":"80000.0","tax":"","discount":"0.0%"}]}]}'
//      });
    FormData formData =
        new FormData.from({"docs": json.encode(widget.data).toString()});

    print(json.encode(widget.data).toString());

    var response = await dio.post(
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,CreateSI.vm",
        data: formData);

    return TransactionResponse.fromJson(json.decode(response.data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
        title: Text("Keranjang Belanja"),
      ),
      body: FutureBuilder<TransactionResponse>(
        future: _dioTransaction(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text("Error");
              } else {
                if(snapshot.data.error == 1){
                  return _buildFailPayment(snapshot, context);
                }else {
                  print(snapshot.data.message);
                  return _buildSuccessPayment(snapshot, context);
                }
              }
          }
          return null;
        },
      ),
    );
  }


}
Widget _buildSuccessPayment(AsyncSnapshot<TransactionResponse> snapshot, BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[

        Container(
            child: Text("Your Payment was Successful")), Container(
            color: Colors.amber,
            child: FlatButton(
              onPressed: (){
                Navigator
                    .of(context)
                    .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => MyOrder()));
              }, child: Text("Lihat Keranjang"),
            ),
        )
      ],
    );

}
Widget _buildFailPayment(AsyncSnapshot<TransactionResponse> snapshot, BuildContext context) {

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              child: Text("Your Payment was Not SuccessFull")),
          Container(
            color: Colors.amber,
            child: FlatButton(
              onPressed: (){
                Navigator.pop(context);
              }, child: Text("Back"),
            ),
          )

        ],
      ),
    );

}



