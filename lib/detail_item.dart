import 'package:flutter/material.dart';



class DetailItem extends StatefulWidget {
  @override
  
  _DetailItemState createState() => _DetailItemState();
}


class _DetailItemState extends State<DetailItem> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  elevation: 0.0,
                  flexibleSpace: FlexibleSpaceBar(
                      background: 
                      Image.asset('assets/item1.png')
                      ),
                ),
          ];
      
        },
      ),),
    );
  }
}