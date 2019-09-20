import 'package:ecommerce_test/models/check_onkir_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PaymentPaymentState extends Equatable {
  PaymentPaymentState([List props = const <dynamic>[]]) : super(props);
}

class InitialPaymentPaymentState extends PaymentPaymentState {}

class GetPriceFeeLoading extends PaymentPaymentState{

}

class GetPriceFeeSuccess extends PaymentPaymentState{
  final CheckOngkirModel deliverFee ;

  GetPriceFeeSuccess(this.deliverFee) : super([deliverFee]);
}

class GetPriceFeeFailed extends PaymentPaymentState {

  final String errorMessage ;

  GetPriceFeeFailed(this.errorMessage): super([errorMessage]);

}
