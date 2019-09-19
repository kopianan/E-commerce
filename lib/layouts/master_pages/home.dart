import 'dart:io';

import 'package:ecommerce_test/data/address_data.dart';
import 'package:ecommerce_test/data/cart_list_data.dart';
import 'package:ecommerce_test/data/list_deliver_fee.dart';
import 'package:ecommerce_test/data/payment_method.dart';
import 'package:ecommerce_test/layouts/pages/cart_page.dart';
import 'package:ecommerce_test/layouts/pages/home_page.dart';
import 'package:ecommerce_test/layouts/pages/category_page.dart';
import 'package:ecommerce_test/layouts/pages/me_page.dart';
import 'package:ecommerce_test/util/shared_preference.dart';
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
  Icon actionIcon = new Icon(Icons.search);
  int _currentIndex = 0;
  static final GlobalKey<ScaffoldState> scaffoldKey =
  new GlobalKey<ScaffoldState>();
  TextEditingController _searchQuery;
  bool _isSearching = false;
  String searchQuery = "Search query";
  @override
  void initState() {
    super.initState();
    _searchQuery = new TextEditingController();
  }

  List<Widget> _children = <Widget>[HomePage(), Category(), PageMe()];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context)=>CartListData(),),
        ChangeNotifierProvider(builder: (context)=>ListDeliverFee(),),
        ChangeNotifierProvider(builder: (context)=>PaymentMethod(),),
        ChangeNotifierProvider(builder: (context)=>AddressData(),),
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
                  onTap: () async{

                    final prefs = await SharedPreferences.getInstance();

                    SharedPreference localData = SharedPreference() ;
                    localData.clearUserData();
                    Navigator.pushReplacement(
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
            title: _isSearching ? _buildSearchField() : _buildTitle(context),
            actions: _buildActions(),
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
                    "Category",
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


  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
    Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return new InkWell(
      onTap: () => scaffoldKey.currentState.openDrawer(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            const Text('ROOMART'),
          ],
        ),
      ),
    );
  }

  void _startSearch() {
    print("open search box");
    ModalRoute
        .of(context)
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    print("close search box");
    setState(() {
      _searchQuery.clear();
      updateSearchQuery("Search query");
    });
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Cari Produk',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: updateSearchQuery,
      onSubmitted: ,
    );
  }

  void updateSearchQuery(String newQuery) {

    setState(() {
      searchQuery = newQuery;
    });
    print("search query " + newQuery);

  }

  List<Widget> _buildActions() {

    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          },
        ),
      )
    ];
  }
}
class DataSearch extends SearchDelegate<String>{
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = "";
    },)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null) ;
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

  }

  @override
  Widget buildSuggestions(BuildContext context) {
  final suggestionList = query.isEmpty?"test": "asdf";
  }

}
