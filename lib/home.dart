
import 'package:ecommerce_test/pages/kategori.dart';
import 'package:ecommerce_test/pages/page_me.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './placeholder_widget.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget appBarTitle = new Text("AppBar Title");
  Icon actionIcon = new Icon(Icons.search);
  int _currentIndex = 0;

  List<Widget> _children = <Widget>[
    HomePage(),
    Kategori(),
    PlaceholderWidget(Colors.yellow),
    PageMe()
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                  MaterialPageRoute(builder: (context) => LoginPage()),
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
          IconButton(
              icon: const Icon(Icons.notifications),
              tooltip: "Show Notification",
              onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.shopping_basket),
            tooltip: "Charts",
            onPressed: () {},
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
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
              icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Text(
                "Timeline",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
              icon: Icon(Icons.timeline)),
          BottomNavigationBarItem(
              title: Text(
                "Notification",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
              icon: Icon(Icons.notifications_active)),
          BottomNavigationBarItem(
              title: Text(
                "Me",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
              icon: Icon(Icons.person)),
        ],
      ),
    ),
    );
  }
}
