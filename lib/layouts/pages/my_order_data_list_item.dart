import 'package:ecommerce_test/models/AllTransactionListModel.dart';
import 'package:flutter/material.dart';

class DataList extends StatelessWidget {
  final AllTransactionListModel data;

  DataList(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: IntrinsicHeight(
            child: Row(children: <Widget>[
              Image.network(
                "https://miro.medium.com/max/800/1*gH1iKXJH8T12LIqhboZWEA.png",
                height: 120.0,
                width: 120.0,
              ),
              Container(
                // color: Colors.indigo,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          data.customerName.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(data.transactionStatus.toString())
                      ],
                    ),
                    Flexible(
                      child: Text(
                        "Order No. " + data.salesOrderNo.toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        data.customerId,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
