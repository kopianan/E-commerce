import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_test/layouts/master_pages/home.dart';
import 'package:ecommerce_test/layouts/master_pages/my_order.dart';
import 'package:ecommerce_test/models/sales_transaction_model.dart';
import 'package:ecommerce_test/models/transaction_response.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return showAlert(
                    context, Icons.error, "Error Transaction", Colors.red, -1);
              } else {
                if (snapshot.data.error == 1) {
                  return showAlert(context, Icons.warning,
                      snapshot.data.message, Colors.yellow, 0);
                } else {
                  print(snapshot.data.message);
                  return showAlert(context, Icons.check_circle,
                      "Transaction Successful", Colors.green, 1);
                }
              }
          }
          return null;
        },
      ),
    );
  }
}

AlertDialog showAlert(BuildContext context, IconData icon, String message,
        Color color, int status) =>
    AlertDialog(
      title: Column(
        children: <Widget>[
          Icon(
            icon,
            color: color,
            size: 80.0,
          ),
          Text(message)
        ],
      ),
      content: raisedButton(context, status),
    );

RaisedButton raisedButton(BuildContext context, int status) {
  if (status == -1 || status == 0) {
    return RaisedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      color: Colors.blueAccent,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        "Kembali",
        style: TextStyle(color: Colors.white),
      ),
    );
  } else {
    return RaisedButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => Home()));
      },
      color: Colors.blueAccent,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        "Ke Home",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
