
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PaymentPaymentState extends Equatable {
  PaymentPaymentState([List props = const <dynamic>[]]) : super(props);
}

class InitialPaymentPaymentState extends PaymentPaymentState {}

class GetArBalanceLoading extends PaymentPaymentState{

}

class GetArBalanceSuccess extends PaymentPaymentState{
  final String arBalance ;

  GetArBalanceSuccess(this.arBalance) : super([arBalance]);
}

class GetArBalanceFailed extends PaymentPaymentState {

  final String errorMessage ;

  GetArBalanceFailed(this.errorMessage): super([errorMessage]);

}
