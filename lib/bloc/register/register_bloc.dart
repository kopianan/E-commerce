import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_test/bloc/register/register_event.dart';
import 'package:ecommerce_test/bloc/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  @override
  RegisterState get initialState => InitialRegisterState();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
