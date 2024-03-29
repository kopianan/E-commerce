import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserEvent extends Equatable {
  UserEvent([List props = const <dynamic>[]]) : super(props);
}

class UserEmailLogin extends UserEvent{
  final String email;
  final String password;

  UserEmailLogin(this.email,this.password):super([email,password]);
}
