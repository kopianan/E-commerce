import 'package:flutter/material.dart'; 



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Secon Route"),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}