import 'package:ecommerce_test/layouts/widgets/cart_list_item.dart';
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final DataItemModel dataItemmodel;

  PaymentPage({@required this.dataItemmodel});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

int _groupValue = -1;

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    DataItemModel data = widget.dataItemmodel;
    return Scaffold(
        appBar: AppBar(
          title: Text("Pembayaran"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: CartListItem(
              dataItemModel: data,
            )),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Icon(
                      Icons.map,
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Text(
                        "Alamat Pengiriman\nadfadfasdfa\nadfadfasdfasdf\nadfgasdfasdf"),
                  ),
                  Expanded(
                    child: Text(
                      "Ubah",
                      style: TextStyle(
                          color: Colors.purple, fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Pengiriman",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Pilih",
                    style: TextStyle(
                        color: Colors.purple, fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Metode Pembayaran",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Pilih",
                    style: TextStyle(
                        color: Colors.purple, fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Informasi Pembayaran",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Subtotal untuk Produk"),
                      Text("Rp. 625.000")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text("Pengiriman"), Text("Rp. 0")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Total diskon pengiriman"),
                      Text("Rp. 0")
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Total diskon pengiriman",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Rp. 625.000",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: FlatButton.icon(
                      icon: Icon(Icons.shopping_basket),
                      color: Colors.yellow,
                      textColor: Colors.purple,
                      onPressed: () {
                        showPaymentPopUp(context);
                      },
                      label: Text(
                        "Lanjutkan Pembayaran",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Future showPaymentPopUp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(child: Text("Pilih Metode Pembayaran")),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _myRadioButton(
                    title: "BANK BCA (Dicek Otomatis)",
                    value: 1,
                    onChanged: (newValue) {
                      setState(() {
                        _groupValue = newValue;
                      });
                    }),
                _myRadioButton(
                    title: "TRANSFER BANK",
                    value: 0,
                    onChanged: (newValue) {
                      setState(() {
                        _groupValue = newValue;
                      });
                    }),
                _myRadioButton(
                    title: "BAYAR DI TEMPAT",
                    value: 0,
                    onChanged: (newValue) {
                      setState(() {
                        _groupValue = newValue;
                      });
                    }),
                _myRadioButton(
                    title: "LAINNYA",
                    value: 0,
                    onChanged: (newValue) {
                      setState(() {
                        _groupValue = newValue;
                      });
                    }),
                Container(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    color: Colors.purple,
                    onPressed: () {},
                    child: Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

Widget _myRadioButton({String title, int value, Function onChanged}) {
  return RadioListTile(
    value: value,
    groupValue: _groupValue,
    onChanged: onChanged,
    title: Text(title),
  );
}
