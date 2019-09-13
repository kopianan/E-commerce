import 'dart:convert';

import 'package:ecommerce_test/data/api_service.dart';
import 'package:ecommerce_test/layouts/pages/my_order_cancel.dart';
import 'package:ecommerce_test/layouts/pages/my_order_finished.dart';
import 'package:ecommerce_test/layouts/pages/my_order_new_transaction.dart';
import 'package:ecommerce_test/layouts/pages/my_order_on_progress.dart';
import 'package:ecommerce_test/layouts/pages/my_order_sent.dart';
import 'package:ecommerce_test/models/AllTransactionListModel.dart';
import 'package:ecommerce_test/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  var dataList = List<AllTransactionListModel>();
  var filteredDataListNew = List<AllTransactionListModel>();
  var filteredDataListConfirmed = List<AllTransactionListModel>();
  var filteredDataListSent = List<AllTransactionListModel>();
  var filteredDataListCancel = List<AllTransactionListModel>();
  var filteredDataListFinished = List<AllTransactionListModel>();

  setDataToList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = User.fromJson(json.decode(prefs.getString("user_data")));
    final allListDataTransaction =
        ApiService.getAllTransactionModel(user.userId);

    allListDataTransaction.then((onValue) {
//  dataList = onValue.where((i)=> i.transactionType == 2).toList();
      setState(() {
        dataList = onValue;

        // ignore: unrelated_type_equality_checks
        filteredDataListNew =
            dataList.where((data) => data.transactionStatus == "1").toList();
        filteredDataListSent =
            dataList.where((data) => data.transactionStatus == "2").toList();
        filteredDataListCancel =
            dataList.where((data) => data.transactionStatus == "5").toList();
        filteredDataListFinished =
            dataList.where((data) => data.transactionStatus == "3").toList();
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
      length: 4,
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 49, 49, 49),
              bottom: TabBar(
                tabs: <Widget>[
                  Center(child: Text("Pesanan Baru", textAlign: TextAlign.center,)),
                  Container(child: Text("Dikirim")),
                  Container(child: Text("Selesai")),
                  Container(child: Text("Batal")),
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
//          body: MainContent(dataListNew : filteredDataListNew, filteredDataListConfirmed)),
          body: MainContent(
            dataListNew: filteredDataListNew,
            dataListDikirim: filteredDataListSent,
            dataListBatal: filteredDataListCancel,
            dataListFinish: filteredDataListFinished,
          )),
    );
  }
}

class MainContent extends StatelessWidget {
  final dataListNew;
  final dataListDikirim;
  final dataListBatal;
  final dataListFinish;

  MainContent(
      {this.dataListNew,
      this.dataListDikirim,
      this.dataListBatal,
      this.dataListFinish});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        MyOrderNewTransaction(
          list: dataListNew,
        ),
        MyOrderSent(datalist: dataListDikirim),
        MyOrderFinished(datalist: dataListFinish,),
        MyOrderCancel(
          datalist: dataListBatal,
        ),
      ],
    );
  }
}
