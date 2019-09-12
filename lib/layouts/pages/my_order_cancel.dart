import 'package:ecommerce_test/models/AllTransactionListModel.dart';
import 'package:flutter/material.dart';

import 'my_order_data_list_item.dart';

class MyOrderCancel extends StatelessWidget {
  final List<AllTransactionListModel> datalist;

  MyOrderCancel({this.datalist});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: datalist.length,
        itemBuilder: (context, index) {
          return DataList(datalist[index]);
        });
  }
}
