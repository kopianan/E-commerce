import 'package:ecommerce_test/models/AllTransactionListModel.dart';
import 'package:flutter/material.dart';

import 'my_order_data_list_item.dart';

class MyOrderOnProgress extends StatefulWidget {
  final List<AllTransactionListModel> datalist;

  MyOrderOnProgress({this.datalist});

  @override
  _MyOrderOnProgressState createState() => _MyOrderOnProgressState();
}

class _MyOrderOnProgressState extends State<MyOrderOnProgress> {
  var filteredList;

  getDataFiltered(int status) {
    print("FilteredList" + widget.datalist.length.toString());
    setState(() {
      filteredList =
          widget.datalist.where((data) => data.transactionStatus == 2).toList();
    });

  }
  @override
  void initState() {
    getDataFiltered(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return DataList(filteredList[index]);
        });
  }
}
