import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:ecommerce_test/bloc/register/register_event.dart';
import 'package:ecommerce_test/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_test/bloc/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  @override
  RegisterState get initialState => InitialRegisterState();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterWithEmail) {
      yield RegisterLoading();
      LoginModel userData = await _registerAsync(
          event.fullName, event.birthDate, event.email, event.password);
      if (userData.error == 1) {
        yield RegisterError(userData.message);
      }else {
        yield RegisterSuccess(userData);
      }
    }
  }

  Future<LoginModel> _registerAsync(
      String fullname, String doB, String email, String password) async {
    final dateOfBirth = intl.DateFormat("dd-MM-yyyy").parse(doB);

    http.Response response;
    response = await http.get(
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,User.vm?method=register&email=$email&password=$password&firstname=$fullname&lastname=$fullname&dobday=${intl.DateFormat("dd").format(dateOfBirth)}&dobmonth=${intl.DateFormat("MM").format(dateOfBirth)}&dobyear=${intl.DateFormat("yyyy").format(dateOfBirth)}&phone=0&address=isialamat&tocust=true&ctype=DM151627192557861134072");

    if (response.statusCode == 200) {
      String jsong = jsonEncode(response.body)
          .toString()
          .replaceAll("\\n", "")
          .replaceAll("\\r", "")
          .replaceAll("\\", "");
      final jsonType = jsong.substring(1, jsong.length - 1);
      LoginModel modelError = LoginModel.fromJson(json.decode(jsonType));
      return modelError;
    } else {
      return null;
    }
  }
}
