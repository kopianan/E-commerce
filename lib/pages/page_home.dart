import 'dart:convert';

import 'package:ecommerce_test/models/data_banner_model.dart';
import 'package:ecommerce_test/widgets/banner_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_test/models/data_item_model.dart';
import 'detail_item.dart';

class PageHome extends StatefulWidget {
  PageHome({Key key}) : super(key: key);
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  String baseUrl = "http://datacloud.erp.web.id:8081";
  List<DataBannerModel> listData;
  List<DataItemModel> itemData;
  @override
  void initState() {

    getDataBanner();

    getItemList();

    super.initState();
  }
   void getItemList() async {
    http.Response response;
    response = await http.get(
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,SPGApps.vm?cmd=2&loccode=GODM&kategoriid=140513828168532755861&limit=1&offset=4");

    if (response.statusCode == 200) {
      List responseJson = await json.decode(response.body);
      final data =
          responseJson.map((m) => new DataItemModel.fromJson(m)).toList();
      setState(() {
        itemData = data;
      });
    }
  }
  void getDataBanner() async {
    http.Response response;
    response = await http.get(
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,SPGBanner.vm");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

      List responseJson = await json.decode(response.body);
      final data =
          responseJson.map((m) => new DataBannerModel.fromJson(m)).toList();

      setState(() {
        listData = data;
      });
    } else {}
    print(listData[0].picture.toString());
  }

  @override
  Widget build(BuildContext context) {
  
    return Container(
      width: double.infinity,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new BannerSlider(listData: listData),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Kategori Belanja",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          "Lihat Ketegori Lainnya",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Text(
                              "Fashion Pria",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              "Fashion Pria",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              "Fashion Pria",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "Promosi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  Row(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: const EdgeInsets.all(10),
                          child: Image.asset('assets/banner2.png')),
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: const EdgeInsets.all(10),
                          child: Image.asset('assets/banner3.png')),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "Rekomendasi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                ],
              ),
            ]),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 9 / 12),
            delegate: SliverChildListDelegate(
              itemData
                  .map(
                    (data) => Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailItem(data)),
                          );
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                               FadeInImage(image: NetworkImage("http://datacloud.erp.web.id:8081${data.pic}"), placeholder: AssetImage('assets/banner2.png')),
                              // Image.network(
                              //     "http://datacloud.erp.web.id:8081${data.pic}"),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Image.asset('assets/SALE.png'),
                                        Flexible(
                                          child: Text(
                                            data.itemName,
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
                                              data.itmPriceFmt,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )),
                                        Container(
                                            child: Text(
                                          data.itmPriceFmt,
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
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
