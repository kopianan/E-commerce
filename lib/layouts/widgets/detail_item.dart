import 'dart:convert';

import 'package:ecommerce_test/layouts/pages/cart_page.dart';
import 'package:ecommerce_test/models/bought_item_model.dart';
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:ecommerce_test/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_test/data/cart_list_data.dart';

class DetailItem extends StatefulWidget {
  final DataItemModel dataOri;

  DetailItem(this.dataOri);

  @override
  _DetailItemState createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  DataItemModel data;
  User userData = User();

  @override
  void initState() {
    data = widget.dataOri;
    getUserData();
    super.initState();
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = User.fromJson(json.decode(prefs.getString("user_data")));

    setState(() {
      userData = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Item"),
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
//        actions: <Widget>[
//          IconButton(
//              icon: const Icon(Icons.notifications),
//              tooltip: "Notifikasi",
//              onPressed: () {
//                print("test");
//              }),
//          IconButton(
//              icon: const Icon(Icons.shopping_basket),
//              tooltip: "Chart",
//              onPressed: () {
//                print("test");
//              }),
//        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: SizedBox(
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                child: Carousel(
                  boxFit: BoxFit.cover,
                  autoplay: false,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 1000),
                  dotSize: 6.0,
                  dotIncreasedColor: Color(0xFFFF335C),
                  dotBgColor: Colors.transparent,
                  dotPosition: DotPosition.bottomCenter,
                  dotVerticalPadding: 0.0,
                  showIndicator: true,
                  images: [
                    Image.network('http://datacloud.erp.web.id:8081${data.pic}')
                    // FadeInImage(image: NetworkImage('http://datacloud.erp.web.id:8081${data.pic}'), placeholder: AssetImage('assets/SALE.png'))
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(data.itemName,
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          child: Text(
                        'Rp. ${data.itmPriceFmt}',
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 20.0),
                      )),
                    ],
                  )
                ],
              ),
            ),

            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.all(3),
                child: Divider(
                  color: Colors.grey,
                )),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    "Rincian Produk",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(data.description),
            ),
            Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Consumer<CartListData>(
                    builder: (context, listData, _) =>
                        Container(
                          width: double.infinity,
                          color: Colors.yellow,
                          child: FlatButton(

                          onPressed: () {
                            data.boughQuantity = "1";
                            listData.addItemListToList(data);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (ctx) => CartPage()),
                            );

//                      var json = jsonEncode(listTransaction.map((e) => e.toJson()).toList());
//                      print( json.encode(listTransaction));
                          },
                          child: Text("Beli Sekarang ")),
                        ),
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}
