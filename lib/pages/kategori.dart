import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ecommerce_test/models/data_banner_model.dart';
import 'package:ecommerce_test/models/kategori_model.dart';
import 'package:ecommerce_test/widgets/banner_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'item_list.dart';

class Kategori extends StatefulWidget {
  Kategori({Key key}) : super(key: key);

  _KategoriState createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
  @override
  void initState() {
    super.initState();

    getDataBanner();
    getCategory();
  }

  String baseUrl = "http://datacloud.erp.web.id:8081";
  List<DataBannerModel> listData;
  List<KategoriModel> listKategori;

  getCategory() async {
    http.Response response;
    response = await http.get(
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,KategoriData.vm");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

      List responseJson = await json.decode(response.body);

      final data =
          responseJson.map((md) => new KategoriModel.fromJson(md)).toList();

      setState(() {
        listKategori = data;
      });
    } else {}
  }

  getDataBanner() async {
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
      child: Column(
        children: <Widget>[
          BannerSlider(
            listData: listData,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: listKategori.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 7 / 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.category),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemList(
                                        listKategori[index].kategoriId,
                                        listKategori[index].description),
                                  ),
                                );
                              },
                            ),
                            Flexible(
                              child: Text(
                                listKategori[index].description,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
