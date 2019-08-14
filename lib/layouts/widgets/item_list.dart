import 'dart:convert';
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:flutter/material.dart';
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
  String categoryname;

  @override
  void initState() {
    super.initState();
    kId = widget.id;
    categoryname = widget.desc;

    _getItemListByCategoryId(kId);
  }

  _getItemListByCategoryId(String id) async {
    http.Response response;
    response = await http.get(
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,SPGApps.vm?cmd=2&loccode=GODM&kategoriid=$id&limit=20&offset=0");

    if (response.statusCode == 200) {
      List responseJson = await json.decode(response.body);
      final data =
          responseJson.map((m) => new DataItemModel.fromJson(m)).toList();
      print(data.toString());
      print(data.toString() + " My Data" + id);

      setState(() {
        listData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.desc + " Kategori"),
      ),
      body: Container(
        child: GridView.builder(
          itemCount: listData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailItem(listData[index])),
                  );
                },
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                          "http://datacloud.erp.web.id:8081${listData[index].pic}"),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.asset('assets/SALE.png'),
                                Flexible(
                                  child: Text(
                                    listData[index].itemName,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Text(
                                      listData[index].itmPriceFmt,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    )),
                                Container(
                                    child: Text(
                                  listData[index].itemPrice,
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold),
                                )),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
