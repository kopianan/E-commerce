import 'package:ecommerce_test/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPayment extends StatefulWidget {
  @override
  _TransactionPaymentState createState() => _TransactionPaymentState();
}

class _TransactionPaymentState extends State<TransactionPayment> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => TransactionBloc(),
      child: TransactionPaymentChild(),
    );
  }
}

class TransactionPaymentChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pembayaran"),
      ),
      body: Column(
        children: <Widget>[

        ],
      ),
    );
  }
}
