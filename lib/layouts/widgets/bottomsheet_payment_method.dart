import 'package:ecommerce_test/data/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPaymentMethodBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentMethod>(
      builder:(context, payment, _)=> Container(

        child: Column(
          mainAxisSize: MainAxisSize.min,

          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Choose Payment Method",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)
                  ,
                )),
            Row(
              children: <Widget>[
                Radio(
                  value: 0,
                  groupValue: payment.selectedPaymentMethod,
                  onChanged: (val){
                    payment.setSelectedRadion(val);
                  },
                ),
                Text("BANK BCA (Dicek Otomatis)")
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: payment.selectedPaymentMethod,
                  onChanged: (val){
                    payment.setSelectedRadion(val);
                  },
                ),
                Text("Transfer Bank")
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 2,
                  groupValue: payment.selectedPaymentMethod,
                  onChanged: (val){
                    payment.setSelectedRadion(val);
                  },
                ),
                Text("Bayar Di Tempat")
              ],
            ) ,Row(
              children: <Widget>[
                Radio(
                  value: 3,
                  groupValue: payment.selectedPaymentMethod,
                  onChanged: (val){
                    payment.setSelectedRadion(val);
                  },
                ),
                Text("Lainnya")
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Konfirmasi", style: TextStyle(color: Colors.black),),
                  color: Colors.amber,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
