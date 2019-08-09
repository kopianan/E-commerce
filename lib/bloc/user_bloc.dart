import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_test/models/user.dart';
import 'package:http/http.dart' as http;
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {

      if(event is UserEmailLogin){
        yield UserLoading();
        final user = await _loginAsync(event.email, event.password);
        yield UserEmailLoginSuccess(user);
      }

    
  }

  Future<User> _loginAsync(String email, String password) async {
    http.Response response;
    response = await http.get(
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,User.vm?method=login&email=$email&password=$password");

    if (response.statusCode == 200) {
      // If the callto the server was successful, parse the JSON

      final user = User.fromJson(json.decode(response.body));
      return user;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
