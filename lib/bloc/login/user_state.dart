import 'package:ecommerce_test/models/login_model.dart';
import 'package:ecommerce_test/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserState extends Equatable {
  UserState([List props = const []]) : super(props);
}

class InitialUserState extends UserState {}

class UserLoading extends UserState{}

class UserEmailLoginSuccess extends UserState{
  final LoginModel user;
  UserEmailLoginSuccess(this.user) : super([user]);
}

class UserEmailLoginFailed extends UserState {
  final String errorMessage;
  UserEmailLoginFailed(this.errorMessage) : super([errorMessage]);
}
