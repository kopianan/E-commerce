import 'package:flutter/material.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Roomart",
        home: Scaffold(
            appBar: AppBar(
              title: Text("Detail Item"),
              backgroundColor: Color.fromARGB(255, 49, 49, 49),
            ),
            body: Card(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/item2.png',
                        width: 120,
                        height: 120,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[Text("Nama"), Text("Kode")],
                          ),
                          Text("Variasi : Pink"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Image.asset('assets/SALE.png'),
                              Row(
                                children: <Widget>[
                                  Text("Rp.350.000"),
                                  Text("Rp. 150.000")
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text("Delivered"),
                        Text("Total Pembayaran : Rp. 150.000")
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}

class CardList extends StatelessWidget {
  const CardList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}
