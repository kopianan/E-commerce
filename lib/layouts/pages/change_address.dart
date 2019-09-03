import 'dart:convert';

import 'package:ecommerce_test/data/address_data.dart';
import 'package:ecommerce_test/models/CityModel.dart' as prefix0;
import 'package:ecommerce_test/models/province_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ChangeAddress extends StatefulWidget {
  @override
  _ChangeAddressState createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {

  String provinceId;
  String provinceName;
  String cityName;
  AddressData data = AddressData();
  List<prefix0.Results> listOfCity = List<prefix0.Results>();
  List<Results> listOfProvince = List<Results>();



  @override
  void initState() {
    getProvinceData();
    super.initState();
  }

  getCityData(String val) async {
    var _baseUrl =
        "https://api.rajaongkir.com/starter/city?key=e1eedfd1a43f04a99122dbcc2f4a0291&province=$val";

    var res = await http.get(_baseUrl);
    var resBody = json.decode(res.body);

    var test = prefix0.CityModel.fromJson(resBody);
    data.setListOfCity(test.rajaongkir.results);
    setState(() {
      listOfCity = test.rajaongkir.results ;
    });

  }

  getProvinceData() async {
    var _baseUrl = "https://api.rajaongkir.com/starter/province";

    var res = await http
        .get(_baseUrl, headers: {"key": "e1eedfd1a43f04a99122dbcc2f4a0291"});
    var resBody = json.decode(res.body);

    var test = ProvinceModel.fromJson(resBody);
    data.setListOfProvince(test.rajaongkir.results);
    setState(() {
      listOfProvince = test.rajaongkir.results;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressData>(
      builder: (context, address, _) => Scaffold(
        appBar: AppBar(
          title: Text("Change Address"),
        ),
        body: Column(
          children: <Widget>[
            TextField(
              onChanged: (String nama) {
                address.nama = nama;
              },
              decoration: const InputDecoration(
                labelText: 'Nama Penerima',
              ),
            ),
            TextField(
              onChanged: (String text) {
                address.noHp = text;
              },
              decoration: const InputDecoration(
                labelText: 'Nomor Handphone',
              ),
            ),
            TextField(
              onChanged: (String text) {
                address.alamat = text;
              },
              decoration: const InputDecoration(
                labelText: 'AlamatLengkap',
              ),
            ),
            Container(
                child: DropdownButton(
                    hint: Text("Pilih Provinsi"),
                    value: provinceName,
                    items: listOfProvince.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item.province),
                        value: item.province.toString(),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        provinceName = newVal;
                        getCityData(address.provinceId);
                      });
                      listOfProvince.forEach((dta){
                        if(dta.province.toString() == provinceName){
                          address.provinceId =  dta.provinceId;
                        }
                      });
                    })),
            Container(
                child: DropdownButton(
                    hint: Text("Pilih Kota"),
                    value: cityName,
                    items: listOfCity.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item.cityName.toString()),
                        value: item.cityName.toString(),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        cityName = newVal;
                      });
                    })),
            Container(
              child: FlatButton(
                onPressed: (){
                  print(address.alamat);
                  print(address.nama);
                  print(address.noHp);


                },
                child: Text("Simpan"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
