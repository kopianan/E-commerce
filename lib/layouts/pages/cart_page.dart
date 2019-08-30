import 'package:ecommerce_test/data/cart_list_data.dart';
import 'package:ecommerce_test/layouts/pages/payment_page.dart';
import 'package:ecommerce_test/layouts/widgets/cart_list_item.dart';
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:flutter/material.dart';
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
              child: CartListItem(
                dataItemModel: dataList.cartListItem[0],
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
                        onPressed: () {},
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
