import 'dart:convert';

import 'package:ecommerce_test/bloc/bloc.dart';
import 'package:ecommerce_test/data/cart_list_data.dart';
import 'package:ecommerce_test/data/list_deliver_fee.dart';
import 'package:ecommerce_test/models/login_model.dart';
import 'package:ecommerce_test/util/function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDeliverMethodBottomSheet extends StatefulWidget {
  @override
  _AddDeliverMethodBottomSheetState createState() =>
      _AddDeliverMethodBottomSheetState();
}

class _AddDeliverMethodBottomSheetState
    extends State<AddDeliverMethodBottomSheet> {
  final _btnBloc = new DeliverBloc();
  final listData = CartListData();
  final data = ListDeliverFee();

  @override
  void initState() {
    _getUserData().then((userData){
    print(userData.province) ;
    print(ListDeliverFee().getProvinceIdFromList(userData.province));
    });
    _btnBloc.dispatch(GetAllPriceOfDeliver(2000, 10, 10));
    super.initState();
  }

  Future<LoginModel> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginModel user = LoginModel.fromJson(json.decode(prefs.getString("user_data")));
    return user ;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ListDeliverFee>(
      builder: (context, data, _) => BlocListener<DeliverBloc, DeliverState>(
        bloc: _btnBloc,
        listener: (context, state) async {
          if (state is GetAllDeliverPriceSuccess) {
            data.setListOngkirDataList(state.listOfOngkir);
            print(data.listOngkir.length.toString() + " JUmlah");
          }
        },
        child: BlocBuilder<DeliverBloc, DeliverState>(
          bloc: _btnBloc,
          builder: (context, state) {
            if (state is GetAllDeliverPriceSuccess) {
              return BuildInitalState();
            } else if (state is GetAllDeliverPriceLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetAllDeliverPriceFailed) {
              return BuildInitalState();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class BuildInitalState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ListDeliverFee>(
      builder: (context, data, _) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Choose Deliver Method",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Expanded(
            child: ListView.builder(
                itemCount: data.listOngkir.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: <Widget>[
                      Radio(
                        value: index,
                        groupValue: data.selected,
                        onChanged: (val) {
                          data.setSelectedOngkir(index);
                          data.setSelectedRadion(val);
                        },
                      ),
                      Text(
                          '${data.listOngkir[index].name} ${data.listOngkir[index].service} ${Fun().formatStringCurrency(data.listOngkir[index].price)} ${data.listOngkir[index].etd} hari')
                    ],
                  );
                }),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "SIMPAN",
                  style: TextStyle(color: Colors.black),
                ),
                color: Colors.amber,
              ),
            ],
          )
        ],
      ),
    );
  }
}
