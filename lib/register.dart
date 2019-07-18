import 'package:flutter/material.dart';
import './home.dart'; 

class TextFieldTemplate extends StatelessWidget {
  final String _label;

  TextFieldTemplate(this._label);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            labelText: _label,
            labelStyle:
                TextStyle(color: Colors.purple, fontStyle: FontStyle.italic),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.blue))),
      ),
    );
  }
}

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 238, 238, 238),
        body: Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(child: Image.asset('assets/LOGO.png')),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextFieldTemplate("Fullname")),
              TextFieldTemplate("Date of birth"),
              TextFieldTemplate("Email"),
              TextFieldTemplate("Username"),
              TextFieldTemplate("Password"),
              TextFieldTemplate("re-enter Password"),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                          "by signing up, you accept the  Terms and Conditions and Privacy Poilicy"),
                    ),
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        },
                        color: Color.fromARGB(255, 130, 39, 74),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
