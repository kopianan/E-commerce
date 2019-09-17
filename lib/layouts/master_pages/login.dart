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
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            builder: ( context) => UserBloc(),
          ),
          BlocProvider<RegisterBloc>(
            builder: ( context) => RegisterBloc(),
          ),
          BlocProvider<CategoryBloc>(
            builder: (context)=> CategoryBloc(),
          ),
          BlocProvider<DeliverBloc>(
            builder: (context) => DeliverBloc(),
          )
        ],
        child: LoginPageChild(),
      ),
    );
  }
}

class LoginPageChild extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: ( context,  state) async {
          if (state is UserEmailLoginSuccess) {
            
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('userFullname', state.user.fullName);
            print(prefs.getString('userFullname'));

            SharedPreference localData = SharedPreference() ;
            localData.saveUserData(state.user);

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
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 238, 238, 238),
      body: SingleChildScrollView(
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
                    suffixIcon:  Icon(Icons.lock,),

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
                          final userBloc = BlocProvider.of<UserBloc>(context);
                          // Initiate getting the weather
                          userBloc.dispatch(UserEmailLogin(
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
      ),
    );
  }

  Widget buildLoading() {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildFailed(String msg) {
    return Scaffold(
      body: Text(msg),
    );
  }
}
