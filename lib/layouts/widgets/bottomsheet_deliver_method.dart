
import 'package:ecommerce_test/data/list_deliver_fee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddDeliverMethodBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ListDeliverFee>(
      builder: (context, data, _)=> Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Choose Deliver Method",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)
                  ,
                )),
            Row(
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: "group",
                ),
                Text("JNE REG  + ${data.jne}")
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: "group",
                ),
                Text("JNE YES")
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: "group",
                ),
                Text("J&T")
              ],
            ) ,Row(
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: "group",
                ),
                Text("TIKI")
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FlatButton(
                  onPressed: (){},
                  child: Text("SIMPAN", style: TextStyle(color: Colors.black),),
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
