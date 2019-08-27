import 'package:ecommerce_test/models/AllTransactionListModel.dart';
import 'package:flutter/material.dart';

class DataList extends StatelessWidget {
  final AllTransactionListModel data  ;
  DataList(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: IntrinsicHeight(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    "https://miro.medium.com/max/800/1*gH1iKXJH8T12LIqhboZWEA.png",
                    height: 120.0,
                    width: 120.0,
                  ),
                  Expanded(
                    child: Container(
                      // color: Colors.indigo,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                data.remark.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Belum Dinilai",
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "Variasi : Pink",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 2.0,
                              ),
                              Text(
                                "Rp. 150.000",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          ),
        ));
  }
}