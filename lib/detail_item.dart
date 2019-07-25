import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class DetailItem extends StatefulWidget {
  @override
  _DetailItemState createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Item"),
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.notifications),
              tooltip: "Notifikasi",
              onPressed: () {
                print("test");
              }),
          IconButton(
              icon: const Icon(Icons.shopping_basket),
              tooltip: "Chart",
              onPressed: () {
                print("test");
              }),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: SizedBox(
              height: 300.0,
              width: MediaQuery.of(context).size.width,
              child: Carousel(
                boxFit: BoxFit.cover,
                autoplay: false,
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(milliseconds: 1000),
                dotSize: 6.0,
                dotIncreasedColor: Color(0xFFFF335C),
                dotBgColor: Colors.transparent,
                dotPosition: DotPosition.bottomCenter,
                dotVerticalPadding: 0.0,
                showIndicator: true,
                images: [
                  Image.asset('assets/item1.png'),
                  Image.asset('assets/item1.png'),
                  Image.asset('assets/item1.png')
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset('assets/SALE.png'),
                    Text("Pink Dress")
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          "Rp. 350.000",
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        )),
                    Container(
                        child: Text(
                      "Rp. 150.000",
                      style: TextStyle(
                          color: Colors.purple, fontWeight: FontWeight.bold),
                    )),
                  ],
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Container(
            child: Row(
              children: <Widget>[
                Image.asset('assets/5stars.png'),
                Text(
                  "4.3/5",
                  style: TextStyle(color: Colors.yellow),
                ),
                Text("|"),
                Text(
                  "92 Terjual / Bulan",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(3),
              child: Divider(
                color: Colors.grey,
              )),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Rincian Produk",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text("3 weeks ago")
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Text(
                "Ukuran \n XS\nS\nL\nXL\n\nBahan : Cotton\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised i"),
          ),
          Expanded(
            child: Align(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: FlatButton(
                  onPressed: () {},
                  child: Text("Beli Sekarang"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
