import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './placeholder_widget.dart';
import './page_home.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget appBarTitle = new Text("AppBar Title");
  Icon actionIcon = new Icon(Icons.search);
  int _currentIndex = 0;

  List<Widget> _children = <Widget>[
    PageHome(),
    PlaceholderWidget(Colors.pink),
    PlaceholderWidget(Colors.yellow),
    PlaceholderWidget(Colors.red)
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
        title: Text("Anan"),
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

    );
  }
}
