import 'dart:convert';
import 'package:ecommerce_test/data/backend_service.dart';
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:http/http.dart' as http;
import 'detail_item.dart';

class ItemList extends StatefulWidget {
  String id;
  String desc;

  ItemList(this.id, this.desc);

  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<DataItemModel> listData;
  String kId;
  static const int PAGE_SIZE = 6;

  @override
  void initState() {
    super.initState();
  }

  Future<List<DataItemModel>> _getItemListByCategoryId(
      String id, offset, limit) async {
    http.Response response;
    response = await http.get(
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,SPGApps.vm?cmd=2&loccode=GODM&kategoriid=$id&limit=$limit&offset=$offset");

    if (response.statusCode == 200) {
      List responseJson = await json.decode(response.body);
      final data =
          responseJson.map((m) => new DataItemModel.fromJson(m)).toList();
      print(data.first.description);
      return data;
    }else
      {
        return null ;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
        title: Text(widget.desc + " Kategori"),
      ),
      body: CustomScrollView(slivers: <Widget>[
        Container(
            child: PagewiseSliverGrid.count(
                pageSize: 6,
                crossAxisCount: 2,
                childAspectRatio: 9 / 16,
                itemBuilder: this._itemBuilder,
                pageFuture: (pageIndex) => _getItemListByCategoryId(
                    widget.id, pageIndex * PAGE_SIZE, PAGE_SIZE))),
      ]),
    );
  }

  Widget _itemBuilder(context, DataItemModel entry, _) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailItem(entry)),
        );
      },
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: FadeInImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "http://datacloud.erp.web.id:8081${entry.pic}"),
                placeholder: AssetImage('assets/broken_image.png'),
              ),
              height: 220.0,
              width: MediaQuery.of(context).size.width / 2.2,
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    entry.itemName,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Rp. ${entry.itmPriceFmt}',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
//                        Text(
//                          "adfadfawdsf",
//                          style: TextStyle(
//                            fontSize: 12.0,
//                            color: Colors.grey,
//                            decoration: TextDecoration.lineThrough,
//                          ),
//                        ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "",
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
//        GridView.builder(
//          itemCount: listData.length,
//          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//            crossAxisCount: 2,
//            childAspectRatio: 2 / 3,
//          ),
//          itemBuilder: (BuildContext context, int index) {
//            return Container(
//              child: InkWell(
//                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => DetailItem(listData[index])),
//                  );
//                },
//                child: Card(
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Image.network(
//                          "http://datacloud.erp.web.id:8081${listData[index].pic}"),
//                      Container(
//                        margin: EdgeInsets.all(10),
//                        child: Column(
//                          children: <Widget>[
//                            Row(
//                              children: <Widget>[
//                                Image.asset('assets/SALE.png'),
//                                Flexible(
//                                  child: Text(
//                                    listData[index].itemName,
//                                    textAlign: TextAlign.left,
//                                    overflow: TextOverflow.ellipsis,
//                                  ),
//                                ),
//                              ],
//                            ),
//                            Row(
//                              children: <Widget>[
//                                Container(
//                                    margin: EdgeInsets.only(right: 5),
//                                    child: Text(
//                                      listData[index].itmPriceFmt,
//                                      style: TextStyle(
//                                          color: Colors.grey,
//                                          decoration:
//                                          TextDecoration.lineThrough),
//                                    )),
//                                Container(
//                                    child: Text(
//                                      listData[index].itemPrice,
//                                      style: TextStyle(
//                                          color: Colors.purple,
//                                          fontWeight: FontWeight.bold),
//                                    )),
//                              ],
//                            )
//                          ],
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//            );
//          },
//        ),
//      ),
//    );
//  }
//}
