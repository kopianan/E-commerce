import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_test/bloc/login/user_event.dart';
import 'package:ecommerce_test/bloc/login/user_state.dart';
import 'package:ecommerce_test/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserEmailLogin) {
      yield UserLoading();
      final user = await _loginAsync(event.email, event.password);
      if (user.error == 1 || user == null ) {
         yield UserEmailLoginFailed("Login Gagal");
      } else {
        yield UserEmailLoginSuccess(user);
      }
    }
  }

  Future<User> _loginAsync(String email, String password) async {
    http.Response response;
    response = await http.get(
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,User.vm?method=login&email=$email&password=$password");

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      // If the callto the server was successful, parse the JSON
      try {
        final user = User.fromJson(json.decode(response.body));
         SharedPreferences prefs = await SharedPreferences.getInstance();
         prefs.setString("user_data", response.body);
        return user;
      } catch (Exception) {
        final user = User.fromJsonError(json.decode(response.body));
        return user;
      }
    } else {
      // If that call was not successful, throw an error.
      print("status code nya bukan 200 cuyy");
      return null;
    }
  }
}
