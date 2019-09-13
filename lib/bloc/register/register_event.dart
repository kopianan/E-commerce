import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const <dynamic>[]]) : super(props);
}

class RegisterWithEmail extends RegisterEvent{
  final String fullName ;
  final String birthDate ;
  final String email;
  final String password;

  RegisterWithEmail(this.email,this.password, this.fullName, this.birthDate):super([email,password, birthDate, password]);
}

