import 'dart:convert';

import 'package:ecommerce_test/bloc/bloc.dart';
import 'package:ecommerce_test/data/payment_method.dart';
import 'package:ecommerce_test/layouts/master_pages/login.dart';
import 'package:ecommerce_test/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPaymentMethodBottomSheet extends StatefulWidget {
  @override
  _AddPaymentMethodBottomSheetState createState() => _AddPaymentMethodBottomSheetState();
}

class _AddPaymentMethodBottomSheetState extends State<AddPaymentMethodBottomSheet> {
  final paymentBloc = PaymentPaymentBloc();
  LoginModel user = LoginModel() ;

  @override
  void initState() {
    super.initState();
    _getUserData().then((val)  {
      user =  val ;
      paymentBloc.dispatch(GetArBalanceAsync(user.userId));
    });

  }

  Future<LoginModel> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginModel user =
    LoginModel.fromJson(json.decode(prefs.getString("user_data")));
    return user;
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentMethod>(
      builder: (context, payment, _) => Container(
        child: BlocListener<PaymentPaymentBloc, PaymentPaymentState>(
          bloc: paymentBloc,
          listener: (BuildContext context, PaymentPaymentState state) async {
            if(state is GetArBalanceSuccess){
              payment.setArBalanceString(state.arBalance);
            }
          },
          child: BlocBuilder<PaymentPaymentBloc, PaymentPaymentState>(
            bloc: paymentBloc,
            builder: (BuildContext context, PaymentPaymentState state) {
              if (state is GetArBalanceLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetArBalanceFailed) {
                return Center(
                  child: Text("Error Get Balance"),
                );
              } else {
                return buildPaymentMethodContent(payment, context);
              }
            },
          ),
        ),
      ),
    );
  }

  Column buildPaymentMethodContent(
      PaymentMethod payment, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Choose Payment Method",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
        Row(
          children: <Widget>[
            Radio(
              value: 0,
              groupValue: payment.selectedPaymentMethod,
              onChanged: (val) {
                payment.setSelectedRadion(val);
              },
            ),
            Text("Deposit (Rp. ${payment.getArBalanceString()})")
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Konfirmasi",
                style: TextStyle(color: Colors.black),
              ),
              color: Colors.amber,
            ),
          ],
        )
      ],
    );
  }
}
