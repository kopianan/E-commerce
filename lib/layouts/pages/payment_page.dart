import 'dart:convert';
import 'dart:math';
import 'package:ecommerce_test/layouts/pages/payment_success_page.dart';
import 'package:ecommerce_test/layouts/widgets/cart_list_item.dart';
import 'package:ecommerce_test/models/bought_item_model.dart';
import 'package:ecommerce_test/models/check_onkir_model.dart';
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:ecommerce_test/models/sales_transaction_detail_model.dart';
import 'package:ecommerce_test/models/sales_transaction_model.dart';
import 'package:ecommerce_test/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  final DataItemModel dataItemmodel;

  PaymentPage({@required this.dataItemmodel});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

int _groupValue = -1;

class _PaymentPageState extends State<PaymentPage> {
  User user;
  User userData = User();

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user =  User.fromJson(json.decode(prefs.getString("user_data")));

    setState(() {
      userData = user ;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  _getPaymentTypeRequest() async {
    final String _baseurl = "https://api.rajaongkir.com/starter/cost";
    final String keyString = "e1eedfd1a43f04a99122dbcc2f4a0291";
    Map<String, String> headers = {"Content-type": "application/json"};
    String requestJne =
        '{"key" : "e1eedfd1a43f04a99122dbcc2f4a0291","origin": "10","destination" : "20","weight" : 1000,"courier" : "tiki"}';

    // make POST request
    http.Response response =
    await http.post(_baseurl, headers: headers, body: requestJne);
    Map jsonResult = await jsonDecode(response.body);
    var ongkir = CheckOngkirModel.fromJson(jsonResult);
    print(ongkir.rajaongkir.results[0].costs[0].cost[0].value.toString() +
        " cost");
  }


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
                  child: Text("address"),
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

                      List<SalesTransactionDetailModel> listDetail = List<SalesTransactionDetailModel>();
                      List<BoughItem> listBoughtItem = List<BoughItem>();
                      SalesTransactionModel listTransaction = SalesTransactionModel();

                      print(new DateFormat("dd/MM/yyyy").format(DateTime.now()));
                      if(userData == null){
                        getUserData();
                      }

                      listBoughtItem.add(BoughItem(
                        itemId: data.itemId,
                        itemCode: data.itemCode,
                        price: data.itemPrice,
                        qty: "1",
                        discount: "",
                        tax: "",
                        unit: "",
                      ));
                      var generatedTransNo;
                      setState(() {
                        generatedTransNo =   _getRandomnumber("APPS-GODM" ,"c");
                      });

                      listDetail.add(SalesTransactionDetailModel(
                          transNo:  generatedTransNo,
                          transType: "SO",
                          location: "GODM",
                          transDt: DateFormat("dd/MM/yyyy").format(DateTime.now()),
                          customer: userData.userId,
                          createBy: "m0101",
                          pmtterm: "",
                          pmttype: "",
                          remark: "",
                          details: listBoughtItem));
                      listTransaction.salesTrans = listDetail;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => PaymentSuccess(data: listTransaction,)),
                      );
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
      ),
    );
  }
}

 String _getRandomnumber(String prefix, String customerId){
   var rnd = Random();
   var next = rnd.nextDouble() * 100;
   while (next < 100) {
     next *= 10;
   }
   var number = prefix + customerId + "/"+ DateFormat("yy/MM").format(DateTime.now())+"/"+ next.toInt().toString().padLeft(3, '0');
   print(number);
   return number ;
 }




Widget _myRadioButton({String title, int value, Function onChanged}) {
  return RadioListTile(
    value: value,
    groupValue: _groupValue,
    onChanged: onChanged,
    title: Text(title),
  );
}
