import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CarouselSlider(
                    height: 150.0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    items: [
                      Image.asset('assets/banner2.png'),
                      Image.asset('assets/banner3.png'),
                      Image.asset('assets/banner2.png'),
                      Image.asset('assets/banner3.png')
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: i,
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Kategori Belanja",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          "Lihat Ketegori Lainnya",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Text(
                              "Fashion Pria",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              "Fashion Pria",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              "Fashion Pria",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "Promosi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  Row(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: const EdgeInsets.all(10),
                          child: Image.asset('assets/banner2.png')),
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: const EdgeInsets.all(10),
                          child: Image.asset('assets/banner3.png')),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "Rekomendasi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                ],
              ),
            ]),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 9 / 12),
            delegate: SliverChildListDelegate([
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/item1.png'),
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
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/item2.png'),
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
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/item1.png'),
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
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/item2.png'),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
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
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/item1.png'),
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
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
