import 'dart:convert';

import 'package:ecommerce_test/layouts/master_pages/my_order.dart';
import 'package:ecommerce_test/util/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/category/category_bloc.dart';
import 'bloc/deliver/deliver_bloc.dart';
import 'bloc/login/user_bloc.dart';
import 'bloc/register/register_bloc.dart';
import 'data/address_data.dart';
import 'data/cart_list_data.dart';
import 'data/list_deliver_fee.dart';
import 'data/payment_method.dart';
import 'layouts/master_pages/home.dart';
import 'layouts/master_pages/login.dart';
import 'models/login_model.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasUserData = false;

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  void _getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    LoginModel user =
    LoginModel.fromJson(json.decode(prefs.getString("user_data")));


    setState(() {
      if (user == null) {
        hasUserData = false;
      } else {
        hasUserData = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(hasUserData);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context)=>CartListData(),),
        ChangeNotifierProvider(builder: (context)=>ListDeliverFee(),),
        ChangeNotifierProvider(builder: (context)=>PaymentMethod(),),
        ChangeNotifierProvider(builder: (context)=>AddressData(),),
      ],
      child: MaterialApp(
          routes: <String, WidgetBuilder> {
            '/home': (BuildContext context) => new Home(),
            '/my_order': (BuildContext context) => new MyOrder(),
          },
        title: 'Navigation Basics',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 49, 49, 49),
        ),
        home:MultiBlocProvider(
          providers: [
            BlocProvider<UserBloc>(
              builder: ( context) => UserBloc(),
            ),
            BlocProvider<RegisterBloc>(
              builder: ( context) => RegisterBloc(),
            ),
            BlocProvider<CategoryBloc>(
              builder: (context)=> CategoryBloc(),
            ),
            BlocProvider<DeliverBloc>(
              builder: (context) => DeliverBloc(),
            )
          ],

          child:hasUserData ? Home() : Login() ,

        )



      ),
    );
  }
}
