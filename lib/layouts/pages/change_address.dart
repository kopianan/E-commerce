import 'dart:convert';

import 'package:ecommerce_test/data/address_data.dart';
import 'package:ecommerce_test/models/CityModel.dart' as prefix0;
import 'package:ecommerce_test/models/province_model.dart';
import 'package:ecommerce_test/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangeAddress extends StatefulWidget {
  @override
  _ChangeAddressState createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {

  String provinceName;
  String cityName;
  String mprovinceid;
  String mcityid;
  AddressData data = AddressData();
  List<prefix0.Results> listOfCity = List<prefix0.Results>();
  List<Results> listOfProvince = List<Results>();

  User user = User();

  Future getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = User.fromJson(json.decode(prefs.getString("user_data")));
    setState(() {
      this.user = user;
    });
  }


  @override
  void initState() {
    getProvinceData();
    getUserData();
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
      listOfCity = test.rajaongkir.results;
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
      builder: (context, address, _) =>
          Scaffold(
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          isExpanded: false,
                            hint: Text("Pilih Provinsi"),
                            value: provinceName,
                            items: listOfProvince.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.province),
                                value: item.province.toString(),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              cityName = null ;
                              listOfCity.clear();
                              provinceName = newVal;
                              listOfProvince.forEach((dta) {
                                if (dta.province.toString() == provinceName) {
                                  setState(() {
                                    mprovinceid = dta.provinceId;
                                    address.setProvince(
                                        dta.provinceId, dta.province);
                                    getCityData(address.provinceId);
                                  });
                                }
                              });
                            })),
                    Container(
                        child:DropdownButton(
                            hint: Text("Pilih Kota"),
                            value: cityName,
                            items: listOfCity.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.type.toString()  + " " + item.cityName.toString()),
                                value: item.type.toString()  + " " +item.cityName.toString(),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              cityName = newVal;
                              listOfCity.forEach((dta) {
                                if (dta.type.toString()  + " " + dta.cityName.toString() == cityName) {
                                  setState(() {
                                    mcityid = dta.cityId ;
                                    address.setCity(dta.cityId, dta.type.toString()  + " " + dta.cityName.toString());
                                  });
                                }
                              });
                            })),

                    Container(
                      width: double.infinity,
                      color: Colors.blueAccent,
                      child: FlatButton(
                        onPressed: () {
                          getUserData();
                          address.getChangedAddress( user.email, address.provinceName,address.cityName, address.alamat);
                          Navigator.pop(context);
                        },
                        child: Text("Simpan", style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
