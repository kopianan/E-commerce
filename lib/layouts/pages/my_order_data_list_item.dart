import 'package:ecommerce_test/models/AllTransactionListModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataList extends StatelessWidget {
  final AllTransactionListModel data;
  final formatter = NumberFormat("#,###");
  DataList(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(5.0),
          child: IntrinsicHeight(
            child: Container(
              // color: Colors.indigo,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      data.salesOrderNo.toString(),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 2,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20) ,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    data.customerName.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        'Qty : ${double.parse(data.totalQty.toString()).toStringAsFixed(0)}',
//                        'Qty : ${double.parse(int.parse(data.totalQty.toString()).toStringAsFixed(0)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Rp. ${formatter.format(int.parse(double.parse(data.totalAmount.toString()).toStringAsFixed(0)))}',
                        style: TextStyle(fontSize: 18, color: Colors.purple, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
