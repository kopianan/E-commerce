import 'package:ecommerce_test/models/AllTransactionListModel.dart';
import 'package:flutter/material.dart';

import 'my_order_data_list_item.dart';

class MyOrderNewTransaction extends StatelessWidget {
  final List<AllTransactionListModel> list;

  MyOrderNewTransaction({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return DataList(list[index]);
        });

//    return Text(list[0].transactionDate);
  }
}


