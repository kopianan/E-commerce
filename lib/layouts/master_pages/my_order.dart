import 'package:ecommerce_test/data/api_service.dart';
import 'package:ecommerce_test/data/cart_list_data.dart';
import 'package:ecommerce_test/layouts/pages/my_order_new_transaction.dart';
import 'package:ecommerce_test/layouts/pages/my_order_on_progress.dart';
import 'package:ecommerce_test/models/AllTransactionListModel.dart';
import 'package:ecommerce_test/models/transaction_history_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  var dataList = List<AllTransactionListModel>();

  setDataToList() {
    final allListDataTransaction = ApiService.getAllTransactionModel();

    allListDataTransaction.then((onValue) {
//  dataList = onValue.where((i)=> i.transactionType == 2).toList();
      setState(() {
        dataList = onValue;
      });
    });
  }

  @override
  void initState() {
    setDataToList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 49, 49, 49),
              bottom: TabBar(
                isScrollable: true,
                tabs: <Widget>[
                  Text("Pesanan Baru"),
                  Text("Dikonfirmasi"),
                  Text("Dikirim"),
                  Text("Selesai"),
                  Text("Batal"),
                ],
              ),
              title: Row(
                children: <Widget>[
                  Icon(Icons.shopping_cart),
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text("Belanja Saya",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)))
                ],
              )),
          body: MainContent(dataList)),
    );
  }
}

class MainContent extends StatelessWidget {
  final dataList;

  MainContent(this.dataList);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        MyOrderNewTransaction(
          list: dataList,
        ),
        MyOrderOnProgress(datalist: dataList),
        Icon(Icons.directions_bike),
        Icon(Icons.directions_bike),
        Icon(Icons.directions_bike),
      ],
    );
  }
}
