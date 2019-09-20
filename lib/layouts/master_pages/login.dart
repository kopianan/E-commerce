import 'package:ecommerce_test/bloc/bloc.dart';
import 'package:ecommerce_test/bloc/login/user_bloc.dart';
import 'package:ecommerce_test/bloc/login/user_event.dart';
import 'package:ecommerce_test/bloc/login/user_state.dart';
import 'package:ecommerce_test/layouts/master_pages/home.dart';
import 'package:ecommerce_test/layouts/master_pages/register.dart';
import 'package:ecommerce_test/util/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
final loginBloc = UserBloc() ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        bloc: loginBloc,
        listener: (context, state) async {
          if (state is UserEmailLoginSuccess) {
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('userFullname', state.user.fullName);
            SharedPreference localData = SharedPreference();
            localData.saveUserData(state.user);
            print("Success push");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          }

          if (state is UserEmailLoginFailed) {
            Toast.show(state.errorMessage, context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
            bloc: loginBloc,
            builder: (context, state) {
              if (state is InitialUserState) {
                return buildInitial(context);
              } else if (state is UserLoading) {
                return buildLoading();
              } else if (state is UserEmailLoginFailed) {
                return buildInitial(context);
              }
              return buildInitial(context);
            }),
      ),
    );
  }


  Widget buildInitial(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/LOGO.png'),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Email / Username ",
                    labelStyle: TextStyle(
                        color: Colors.purple, fontStyle: FontStyle.italic),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.lock,),

                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Password ",
                    labelStyle: TextStyle(
                        color: Colors.purple, fontStyle: FontStyle.italic),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    "Forgot Password ?   ",
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.purple),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "click here",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          color: Colors.purple,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () async {
                        // Initiate getting the weather
                        loginBloc.dispatch(UserEmailLogin(
                            emailController.text.toString(),
                            passwordController.text.toString()));

                        // _saveUser("Data");
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Home()),
                        // );
                      },
                      color: Color.fromARGB(255, 130, 39, 74),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                'or login by',
                style: TextStyle(color: Color.fromARGB(255, 130, 39, 74)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FacebookSignInButton(onPressed: () {}),
                  GoogleSignInButton(onPressed: () {}, darkMode: true),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                'Doesn\'t have account?',
                style: TextStyle(color: Color.fromARGB(255, 130, 39, 74)),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                color: Color.fromARGB(255, 130, 39, 74),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Register NOW!",
                  style: TextStyle(color: Colors.yellowAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

}