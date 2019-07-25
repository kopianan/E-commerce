import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TukarPoint extends StatefulWidget {
  @override
  _TukarPointState createState() => _TukarPointState();
}

class _TukarPointState extends State<TukarPoint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 97, 1, 90),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Color.fromARGB(255, 97, 1, 90),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(50),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Total Point",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Container(
                    child: Text(
                      "4.500",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Image.asset('assets/point_image1.png'),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Image.asset('assets/point1.png'),
                        width: 50,
                        height: 50,
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Voucher Gratis Ongkir hinggal 50.0000",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "156 Terjual",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: RaisedButton(
                            
                            child: Text("BELI", style: TextStyle(fontWeight: FontWeight.bold),),
                            onPressed: () {},
                            color: Colors.yellow,
                            textColor: Colors.deepPurple,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
