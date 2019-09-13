import 'dart:convert';
import 'package:ecommerce_test/data/cart_list_data.dart';
import 'package:ecommerce_test/models/AllTransactionListModel.dart';
import 'package:ecommerce_test/models/detail_transaction_model.dart';
import 'package:ecommerce_test/models/login_model.dart';
import 'package:ecommerce_test/util/function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionDetail extends StatefulWidget {
  final AllTransactionListModel listData ;

  TransactionDetail(this.listData);
  @override
  _TransactionDetailState createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  LoginModel dataUser = LoginModel() ;
  DetailTransactionModel dataOngkir  = DetailTransactionModel() ;
  Future<List<DetailTransactionModel>> getDetailTransaction() async {
    http.Response response;
    response = await http.get(
       "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,SPGApps.vm?cmd=4&txtype=SO_DETAIL&txno=${widget.listData.salesOrderId}");

    List responseJson = await json.decode(response.body);

    print(response.body);
    final data = responseJson
        .map((md) => new DetailTransactionModel.fromJson(md))
        .toList();

    return data.cast();
  }


  Future getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginModel user = LoginModel.fromJson(json.decode(prefs.getString("user_data")));
    setState(() {
      this.dataUser = user;
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartListData>(
      builder:(context, selected, _)=> Scaffold(
        appBar: AppBar(
          title: Text("Detail Item"),
          backgroundColor: Color.fromARGB(255, 49, 49, 49),
        ),
        body: FutureBuilder<List<DetailTransactionModel>>(
          future: getDetailTransaction(),
          builder: (context , snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                if (snapshot.hasData) {
                  selected.setSelectedTransactionDetail(widget.listData);
                    dataOngkir = snapshot.data.first;



                  return buildCustomScrollView(snapshot.data, selected.selectedTransactionDetail);
                }else {
                  Navigator.pop(context);
                }

            }
            return Center(child: CircularProgressIndicator());
          }
        ),
      ),
    );
  }

  CustomScrollView buildCustomScrollView(List<DetailTransactionModel> data, AllTransactionListModel transDetail) {
    return CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildAlamatPengirim(transDetail),
                SizedBox(
                  height: 20,
                ),
                buildStatusPemesanan(transDetail),
                SizedBox(
                  height: 20,
                ),
                buildNomorPesanan(transDetail),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                //data yang masuk tidak termasuk ongkos kirim
                return buildItemList(data, index+1);

              },
              childCount: data.length-1,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildInformasiPembayaran(transDetail),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Total Pembayaran", style: TextStyle(fontSize: 16)),
                      Text('Rp. ${Fun().formatStringCurrency(transDetail.totalAmount)}', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Metode Pembayaran", style: TextStyle(fontSize: 16)),
                      Text("Bank BCA (dicek otomatis)", style: TextStyle(fontSize: 16),),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      );
  }

  Padding buildInformasiPembayaran(AllTransactionListModel transDetail) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Informasi Pembayaran",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Sub total untuk produk", style: TextStyle(fontSize: 16)),
                      Text("Rp. ${Fun().formatStringCurrency((int.parse(double.parse(transDetail.totalAmount).toStringAsFixed(0)) -int.parse(double.parse(dataOngkir.subTotal).toStringAsFixed(0))).toString())}",  style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Ongkos Kirim",  style: TextStyle(fontSize: 16)),
                      Text("Rp. ${Fun().formatStringCurrency(dataOngkir.subTotal)}",  style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildNomorPesanan(AllTransactionListModel transDetail) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Nomor Pesanan",  style: TextStyle(fontSize: 16)),
            Text(
              transDetail.salesOrderNo,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildStatusPemesanan(AllTransactionListModel transDetail) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: 60,
                child: Icon(
                  Icons.directions_car,
                  color: Colors.green,
                )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Status Pengiriman",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("${dataUser.fullName}"),
                  Text("${dataUser.phone}"),
                ],
              ),
            ),
            Text("Lacak> "),
          ],
        ),
      ),
    );
  }

  Padding buildAlamatPengirim(AllTransactionListModel transDetail) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(width: 60, child: Icon(Icons.map)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Alamat Pengiriman",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(transDetail.customerName),
                  Text(dataUser.phone.toString()),
                  Text('${dataUser.address}, ${dataUser.city}, ${dataUser.province}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildItemList(List<DetailTransactionModel> data, int index) {

  return InkWell(
    onTap: () {},
    child: Card(
      elevation: 4.0,
      child: Container(
        height: 120.0,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/banner2.png",
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 4.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data[index].itemName,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                  SizedBox(height: 7.0),
                  Text(
                    'Jumlah : ${data[index].qty}',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.grey),
                  ),
                  SizedBox(height: 7.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Rp. ${Fun().formatStringCurrency(data[index].itemPrice)}',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15.0,),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          'Rp. ${Fun().formatStringCurrency(data[index].subTotal)}',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.deepPurple),
                        ),
                      ),
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
}
