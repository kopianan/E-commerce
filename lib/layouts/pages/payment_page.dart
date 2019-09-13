import 'dart:convert';
import 'dart:math';
import 'package:ecommerce_test/data/address_data.dart';
import 'package:ecommerce_test/data/cart_list_data.dart';
import 'package:ecommerce_test/data/list_deliver_fee.dart';
import 'package:ecommerce_test/data/payment_method.dart';
import 'package:ecommerce_test/layouts/pages/payment_success_page.dart';
import 'package:ecommerce_test/layouts/widgets/bottomsheet_deliver_method.dart';
import 'package:ecommerce_test/layouts/widgets/bottomsheet_payment_method.dart';
import 'package:ecommerce_test/layouts/widgets/cart_list_item.dart';
import 'package:ecommerce_test/models/CityModel.dart';
import 'package:ecommerce_test/models/CityModel.dart' as city;
import 'package:ecommerce_test/models/bought_item_model.dart';
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:ecommerce_test/models/login_model.dart';
import 'package:ecommerce_test/models/province_model.dart';
import 'package:ecommerce_test/models/province_model.dart' as prefix0;
import 'package:ecommerce_test/models/sales_transaction_detail_model.dart';
import 'package:ecommerce_test/models/sales_transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'change_address.dart';

class PaymentPage extends StatefulWidget {
  final DataItemModel dataItemmodel;

  PaymentPage({@required this.dataItemmodel});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

int _groupValue = -1;

class _PaymentPageState extends State<PaymentPage> {
  LoginModel user;
  var newValProvince;
  String dropdownValue = 'One';
  AddressData addData = AddressData() ;

  List<prefix0.Results> listOfResult = List<prefix0.Results>();
  List<city.Results> listOfCity = List<city.Results>();
  final formatter = new NumberFormat("#,###");

  @override
  void initState() {
    super.initState();
    AddressData().getProvinceData();
    getUserData();

  }

  Future getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginModel user = LoginModel.fromJson(json.decode(prefs.getString("user_data")));
    setState(() {
      this.user = user;
      AddressData().userData = user ;
    });
  }



  getCityData(String val) async {
    var _baseUrl =
        "https://api.rajaongkir.com/starter/city?key=e1eedfd1a43f04a99122dbcc2f4a0291&province=$val";

    var res = await http.get(_baseUrl);
    var resBody = json.decode(res.body);

    var test = CityModel.fromJson(resBody);
    setState(() {
      listOfCity = test.rajaongkir.results;
    });
  }

  getProvinceData() async {
    var _baseUrl = "https://api.rajaongkir.com/starter/province";

    var res = await http
        .get(_baseUrl, headers: {"key": "e1eedfd1a43f04a99122dbcc2f4a0291"});
    var resBody = json.decode(res.body);

    var test = ProvinceModel.fromJson(resBody);
    setState(() {
      listOfResult = test.rajaongkir.results;
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
          Consumer<AddressData>(
            builder: (context, addressData, _) => Consumer<ListDeliverFee>(
              builder: (context, listDeliver, _) => Container(
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
                      child: addressData.userData == null
                          ? Text("Alamat")
                          : Text(
                              '${addressData.userData.address}\n${addressData.userData.province}\n${addressData.userData.city}'),
                    ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => ChangeAddress()),
                            );
                          },
                          child: Text(
                            "Ubah",
                            style: TextStyle(
                                color: Colors.purple,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Consumer<AddressData>(
            builder: (context, addressData, _) => Consumer<CartListData>(
              builder: (context, listData, _) => Consumer<ListDeliverFee>(
                builder: (context, data, _) => Container(
                  margin: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Pengiriman",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          addressData.getProvinceData();
                          data.getAllProvinceAndCity();
                          data.multipleRequest(
                              listData.getAllItemWeight(),
                              data.getProvinceIdFromList(
                                  addressData.userData.city));
                          _getRandomnumber(
                              "APPS-GODM", addressData.userData.userId);
                          showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  AddDeliverMethodBottomSheet());
                        },
                        child: buildChoosePengiriman(data),
                      ),
                    ],
                  ),
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
                        Text(
                          "Rp. " +
                              formatter.format(int.parse(
                                  double.parse(listData.getSubTotal())
                                      .toStringAsFixed(0))),
                          style: subTextStyle(),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Pengiriman"),
                        Text(
                          "Rp. " +
                              formatter.format(int.parse(
                                listDeliver.selectedOngkir.price.toString()
                              )),
                          style: subTextStyle(),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Total Bayar",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Rp." +
                                listData.getTotalBayar(
                                    listDeliver.selectedOngkir.price,
                                    listData.getSubTotal()),
                            style: totalTextStyle(),
                          ),
                        ],
                      ),
                    ),
                    Consumer<AddressData>(
                      builder: (context, address, _) => Container(
                        margin: EdgeInsets.only(top: 20),
                        width: double.infinity,
                        child: FlatButton.icon(
                          icon: Icon(Icons.shopping_basket),
                          color: Colors.yellow,
                          textColor: Colors.purple,
                          onPressed: () {
                            _generatePostTransactiondata(listData, listDeliver,
                                address.userData, context);
                          },
                          label: Text(
                            "Lanjutkan Pembayaran",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
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

  Text buildChoosePengiriman(ListDeliverFee data) {
    if (data.selectedOngkir.name == null) {
      return Text(
        "Pilih",
        style: subTextStyle(),
      );
    } else {
      return Text(
        data.selectedOngkir.name.toString() +
            "\n" +
            formatter.format(int.parse(data.selectedOngkir.price)).toString() +
            " ( " +
            data.selectedOngkir.etd.toString() +
            " hari)",
        maxLines: 3,
        textAlign: TextAlign.right,
        style: subTextStyle(),
      );
    }
  }
}

TextStyle totalTextStyle() {
  return TextStyle(
      color: Colors.purple, fontSize: 18, fontWeight: FontWeight.bold);
}

TextStyle subTextStyle() {
  return TextStyle(color: Colors.purple, fontSize: 16);
}

Text buildTextPaymentMethod(int index) {
  var text = "";
  if (index == 0) {
    text = ("DEPOSIT");
  } else if (index == 1) {
    text = ("Transfer Bank");
  } else if (index == 2) {
    text = ("Bayar Ditempat");
  } else if (index == 3) {
    text = ("Lainnys");
  } else {
    text = "Pilih";
  }
  return Text(text, style: subTextStyle());
}

void _generatePostTransactiondata(CartListData listData,
    ListDeliverFee listDeliver, LoginModel userData, BuildContext context) {
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
    itemCode:
        (listDeliver.selectedOngkir.name + listDeliver.selectedOngkir.service),
    price: listDeliver.selectedOngkir.price,
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
