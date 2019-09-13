import 'package:ecommerce_test/models/error_message.dart';
import 'package:ecommerce_test/models/login_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterState extends Equatable {
  RegisterState([List props = const <dynamic>[]]) : super(props);
}

class InitialRegisterState extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterSuccess extends RegisterState {
  final ErrorTest user;
  RegisterSuccess(this.user) : super([user]);
}

class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message) : super([message]);
}
