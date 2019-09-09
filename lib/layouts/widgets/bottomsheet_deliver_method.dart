
import 'package:ecommerce_test/data/list_deliver_fee.dart';
import 'package:ecommerce_test/util/function.dart';
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
            Expanded(
              child: ListView.builder(
                  itemCount: data.listOngkir.length,
                  itemBuilder: (BuildContext context, int index){
                    return Row(
                      children: <Widget>[
                        Radio(
                          value: index,
                          groupValue:data.selected,
                          onChanged: (val){
                            data.setSelectedOngkir(index);
                            data.setSelectedRadion(val);
                          },
                        ),
                        Text('${data.listOngkir[index].name} ${data.listOngkir[index].service} ${Fun().formatStringCurrency(data.listOngkir[index].price)} ${data.listOngkir[index].etd} hari')
                      ],
                    );

              }),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
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
