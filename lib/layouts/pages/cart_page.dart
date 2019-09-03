import 'package:ecommerce_test/data/cart_list_data.dart';
import 'package:ecommerce_test/layouts/pages/payment_page.dart';
import 'package:ecommerce_test/layouts/widgets/cart_list_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
        title: Text("Keranjang Belanja"),
      ),
      body: Consumer<CartListData>(
        builder: (context, dataList, _) => Column(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: CartListItem(),
            ),
            Consumer<CartListData> (
              builder:(context, data, _)=> Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text("Total Belanja",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      child: Text('Rp. ${data.getSumOfPriceProduct().toString()}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: new Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width / 2,
                      child: new FlatButton(
                        textColor: Colors.yellow,
                        onPressed: () {
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(builder: (context) => Home()),
//                          );
                        Navigator.pop(context);
                        Navigator.pop(context);
                        },
                        child: Text(
                          "Saya Masih Ingin Belanja",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.yellow,
                      width: MediaQuery.of(context).size.width / 2,
                      child: new FlatButton(
                        textColor: Colors.pink,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentPage(
                                    dataItemmodel: dataList.cartListItem[0])),
                          );
                        },
                        child: Text(
                          "Lanjutkan Pembayaran",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
