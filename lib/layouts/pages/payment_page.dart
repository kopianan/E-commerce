import 'dart:convert';
import 'dart:math';
import 'package:ecommerce_test/data/cart_list_data.dart';
import 'package:ecommerce_test/data/list_deliver_fee.dart';
import 'package:ecommerce_test/data/payment_method.dart';
import 'package:ecommerce_test/layouts/pages/payment_success_page.dart';
import 'package:ecommerce_test/layouts/widgets/bottomsheet_deliver_method.dart';
import 'package:ecommerce_test/layouts/widgets/bottomsheet_payment_method.dart';
import 'package:ecommerce_test/layouts/widgets/cart_list_item.dart';
import 'package:ecommerce_test/models/bought_item_model.dart';
import 'package:ecommerce_test/models/check_onkir_model.dart';
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:ecommerce_test/models/sales_transaction_detail_model.dart';
import 'package:ecommerce_test/models/sales_transaction_model.dart';
import 'package:ecommerce_test/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
    User user = User.fromJson(json.decode(prefs.getString("user_data")));

    setState(() {
      userData = user;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  _getPaymentTypeRequest() async {
    final String _baseurl = "https://api.rajaongkir.com/starter/cost";
    final List<String> listPengiriman = ["jne", "tiki"];

    final String keyString = "e1eedfd1a43f04a99122dbcc2f4a0291";
    Map<String, String> headers = {"Content-type": "application/json"};

    // make POST request
    listPengiriman.forEach((it) async {
      String requestJne =
          '{"key" : "e1eedfd1a43f04a99122dbcc2f4a0291","origin": "10","destination" : "20","weight" : 1000,"courier" : "${it.toString()}"}';

      http.Response response =
          await http.post(_baseurl, headers: headers, body: requestJne);
      Map jsonResult = await jsonDecode(response.body);
      var ongkir = CheckOngkirModel.fromJson(jsonResult);
      print(ongkir.rajaongkir.results[0].costs[0].cost[0].value.toString() +
          " cost $it");
    });
  }

  @override
  Widget build(BuildContext context) {
    DataItemModel data = widget.dataItemmodel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
        title: Text("Pembayaran"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: CartListItem()),
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
                  child: userData.address == null
                      ? Text("Alamat")
                      : Text(userData.address),
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
          Consumer<CartListData>(
            builder: (context, listData, _) => Consumer<ListDeliverFee>(
              builder: (context, data, _) => Container(
                margin: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Pengiriman",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        data.multipleRequest(listData.getAllItemWeight());
                        _getRandomnumber("APPS-GODM", userData.userId);
                        showModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                AddDeliverMethodBottomSheet());
                      },
                      child: _getPengirimanStatus(data),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Consumer<PaymentMethod>(
            builder: (context, pay, _) => Container(
              margin: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Metode Pembayaran",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => AddPaymentMethodBottomSheet());
                    },
                    child: buildTextPaymentMethod(pay.selectedPaymentMethod),
                  )
                ],
              ),
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
          Consumer<ListDeliverFee>(
            builder: (context, listDeliver, _) => Consumer<CartListData>(
              builder: (context, listData, _) => Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Subtotal untuk Produk"),
                        Text(listData.getSubTotal().toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Pengiriman"),
                        Text(listDeliver
                            .getSubTotalOngkir(listData.getAllItemWeight())
                            .toStringAsFixed(0))
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
                          buildTotal(listData, listDeliver),
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
                          _generatePostTransactiondata(
                              listData, listDeliver, userData, context);

//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (ctx) => PaymentSuccess(
//                                      data: listTransaction,
//                                    )),
//                          );
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
              ),
            ),
          )
        ],
      ),
    );
  }

  Text buildTextPaymentMethod(int index) {
    var text = "";
    if(index == 0){
      text =("BANK BCA");
    }else if(index == 1){
      text =("Transfer Bank");
    }else if(index ==2){
      text =("Bayar Ditempat");
    }else if (index ==3){
      text =("Lainnys");
    }else {
      text ="Pilih";
    }
    return Text(
      text,
      style: TextStyle(color: Colors.purple, fontStyle: FontStyle.italic),
    );
  }

  Text buildTotal(CartListData listData, ListDeliverFee listDeliver) {
    double subTotal;
    double subTotalOngkir;

    if (double.parse(listData.getSubTotal()) == null ||
        double.parse(listData.getSubTotal()) == 0.0) {
      subTotal = 0.0;
    } else {
      subTotal = double.parse(listData.getSubTotal());
    }

    if (double.parse(listDeliver
                .getSubTotalOngkir(listData.getAllItemWeight())
                .toString()) ==
            null ||
        double.parse(listDeliver
                .getSubTotalOngkir(listData.getAllItemWeight())
                .toString()) ==
            0.0) {
      subTotalOngkir = 0.0;
    } else {
      subTotalOngkir = double.parse(listDeliver
          .getSubTotalOngkir(listData.getAllItemWeight())
          .toString());
    }

    return Text(
      '${(subTotal + subTotalOngkir).toString()}',
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purple),
    );
  }
}

void _generatePostTransactiondata(CartListData listData,
    ListDeliverFee listDeliver, User userData, BuildContext context) {
  List<SalesTransactionDetailModel> listDetail =
      List<SalesTransactionDetailModel>();
  List<BoughItem> listBoughtItem = List<BoughItem>();
  SalesTransactionModel listTransaction = SalesTransactionModel();

  print(new DateFormat("dd/MM/yyyy").format(DateTime.now()));

  listData.cartListItem.forEach((data) {
    listBoughtItem.add(BoughItem(
      itemId: data.itemId,
      itemCode: data.itemCode,
      price: data.itemPrice,
      qty: data.boughQuantity,
      discount: "",
      tax: data.taxCode,
      unit: data.unitCode,
    ));
  });
//  {"item_code":"ONGKIR","item_id":"DM156698902369200428418","qty":"1","unit":"PCS","price":"disesuaikan","tax":"","discount":"0.0%"}]}]}

  listBoughtItem.add(BoughItem(
    itemId: "DM156698902369200428418",
    itemCode: _getPengiriman(listDeliver.selected),
    price:
        listDeliver.getSubTotalOngkir(listData.getAllItemWeight()).toString(),
    qty: "1",
    discount: "",
    tax: "1",
    unit: "0",
  ));

  var generatedTransNo = _getRandomnumber("APPS-GODM", userData.userId);

  listDetail.add(SalesTransactionDetailModel(
      transNo: generatedTransNo,
      transType: "SO",
      location: "GODM",
      transDt: DateFormat("dd/MM/yyyy").format(DateTime.now()),
      customer: userData.userId,
      createBy: userData.fullName,
      pmtterm: "",
      pmttype: "",
      remark: "",
      details: listBoughtItem));
  listTransaction.salesTrans = listDetail;

  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (ctx) => PaymentSuccess(
              data: listTransaction,
            )),
  );
  print(json.encode(listTransaction.toJson()).toString());
}

String _getPengiriman(int selected) {
  if (selected == 0) {
    return "JNE REG";
  } else if (selected == 1) {
    return "JNE OKE";
  } else if (selected == 2) {
    return "TIKI REG";
  } else
    return "ONGKIR";
}

Text _getPengirimanStatus(ListDeliverFee data) {
  if (data.selected == 0) {
    return Text("JNE " + data.jneReg);
  } else if (data.selected == 1) {
    return Text("JNE " + data.jneOke);
  } else if (data.selected == 2) {
    return Text("TIKI " + data.tiki);
  } else {
    return Text("Pilih");
  }
}

String _getRandomnumber(String prefix, String customerId) {
  var rnd = Random();
  var next = rnd.nextDouble() * 100;
  while (next < 100) {
    next *= 10;
  }
  var number = prefix +
      customerId.substring(customerId.length - 4, customerId.length) +
      "/" +
      DateFormat("yyMM").format(DateTime.now()) +
      "/" +
      next.toInt().toString().padLeft(3, '0');
  print(number);
  return number;
}

Widget _myRadioButton({String title, int value, Function onChanged}) {
  return RadioListTile(
    value: value,
    groupValue: _groupValue,
    onChanged: onChanged,
    title: Text(title),
  );
}
