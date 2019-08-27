import 'package:flutter/material.dart';

class AddPaymentMethodBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

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
                value: 1,
                groupValue: "group",
              ),
              Text("BANK BCA (Dicek Otomatis)")
            ],
          ),
          Row(
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: "group",
              ),
              Text("Transfer Bank")
            ],
          ),
          Row(
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: "group",
              ),
              Text("Bayar Di Tempat")
            ],
          ) ,Row(
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: "group",
              ),
              Text("Lainnya")
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FlatButton(
                onPressed: (){},
                child: Text("Konfirmasi", style: TextStyle(color: Colors.black),),
                color: Colors.amber,
              ),
            ],
          )
        ],
      ),
    );
  }
}
