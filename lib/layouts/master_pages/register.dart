import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import './home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String fullName = "";

  String email = "";

  String userName = "";

  String password = "";
  String confirmPassword = "";

  String dob = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 238, 238),
      body: buildRegisterContent(context),
    );
  }

  Container buildRegisterContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40, top: 40),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(child: Image.asset('assets/LOGO.png')),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextField(decoration: textFieldDecoration("Fullname")),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                  onChanged: (val) {
                    setState(() {});
                  },
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      print('confirm $date');
                    }, currentTime: DateTime.now(), locale: LocaleType.id);
                  },
                  decoration: textFieldDecoration("Date of birth")),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: textFieldDecoration("Email")),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                  onChanged: (val) {
                    password = val;
                  },
                  decoration: textFieldDecoration("Password")),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                  onChanged: (val) {
                    confirmPassword = val;
                  },
                  decoration: textFieldDecoration("re-enter Password")),
            ),
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
    );
  }

  InputDecoration textFieldDecoration(String _label) {
    return InputDecoration(
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
            borderSide: BorderSide(color: Colors.blue)));
  }
}
