import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_test/bloc/register/register_event.dart';
import 'package:ecommerce_test/models/error_message.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_test/bloc/register/register_state.dart';
import 'package:ecommerce_test/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  @override
  RegisterState get initialState => InitialRegisterState();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterWithEmail) {
      yield RegisterLoading();
      final userData = await _registerAsync(
          event.fullName, event.birthDate, event.email, event.password);
      if (userData.error == null || userData.error == 1) {
        yield RegisterError("Something Wrong");
      } else {
        yield RegisterSuccess(userData);
      }
    }
  }

  Future<ErrorTest> _registerAsync(
      String fullname, String doB, String email, String password) async {
    http.Response response;
    print("Register CUYY");
    response = await http.get(
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,User.vm?method=register&email=alfred@gmail.com&password=123&firstname=anan&lastname=anan&dobday=12&dobmonth=12&dobyear=2001&tocust=true&ctype=DM151627192557861134072");

    if (response.statusCode == 200) {
      if (response.body.toString().split(",")[0].contains("1")) {
        return ErrorTest(error: 1, message: "Error");
      } else {
        return ErrorTest(error: 0, message: "Error");
      }
    } else {
      // If that call was not successful, throw an error.
      print("status code nya bukan 200 cuyy");
      return null;
    }
  }
}
