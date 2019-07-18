import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(height: 200,child:Text(""), color: Colors.black,),
          Card(
            child: Container(
                padding: EdgeInsets.all(20), child: Text("KATEGORI BELANJA")),
          ),
        ],
      ),
    );
  }
}
