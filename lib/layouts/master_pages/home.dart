import 'package:ecommerce_test/data/cart_list_data.dart';
import 'package:ecommerce_test/data/list_deliver_fee.dart';
import 'package:ecommerce_test/layouts/pages/home_page.dart';
import 'package:ecommerce_test/layouts/pages/category_page.dart';
import 'package:ecommerce_test/layouts/pages/me_page.dart';
import 'package:ecommerce_test/layouts/widgets/placeholder_widget.dart';
import 'package:ecommerce_test/models/user.dart';
import 'package:ecommerce_test/util/shared_preference.dart' as localData;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget appBarTitle = new Text("AppBar Title");
  Icon actionIcon = new Icon(Icons.search);
  int _currentIndex = 0;

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  List<Widget> _children = <Widget>[HomePage(), Category(), PageMe()];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _getUserData() async {
    // localData.SharedPreference userData = SharedPreference();
    // User user = await userData.getUserData();

    final prefs = await SharedPreferences.getInstance();
    String userData = "";
    userData = prefs.getString("user_data_preference");
    // print("USER LOCAL DATA : "+ userData);

    // userData = prefs.getString('userFullname');
    // print("USER DATA : "+user.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context)=>CartListData(),),
        ChangeNotifierProvider(builder: (context)=>ListDeliverFee(),),

      ],
      child: MaterialApp(
        home: Scaffold(
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text(
                    'Menu',
                    style: TextStyle(color: Colors.yellowAccent),
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 49, 49, 49),
                  ),
                ),
                ListTile(
                  title: Text('Tentang'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Keluar'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 49, 49, 49),
            title: Text("Roomart Dashboard"),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: "Search",
                  onPressed: () {
                    print("test");
                  }),
              Consumer<CartListData>(
                builder: (context, data, _) => IconButton(
                  icon: Stack(children: <Widget>[
                    new Icon(Icons.shopping_cart),
                    new Positioned(
                      // draw a red marble
                      top: 0.0,
                      right: 0.0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          data.cartListItem.length.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ]),
                  tooltip: "Charts",
                  onPressed: () {},
                ),
              )
            ],
          ),
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: _onTabTapped,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  title: Text(
                    "Home",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                  icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  title: Text(
                    "Timeline",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                  icon: Icon(Icons.timeline)),
              BottomNavigationBarItem(
                  title: Text(
                    "Me",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                  icon: Icon(Icons.person)),
            ],
          ),
        ),
      ),
    );
  }

  static SharedPreference() {}
}
