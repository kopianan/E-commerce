import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PaymentPaymentEvent extends Equatable {
  PaymentPaymentEvent([List props = const <dynamic>[]]) : super(props);
}

class GetDeliverFee extends PaymentPaymentEvent {
  final String key;

  final String origin;

  final String destination;

  final int weight;

  final String courier;

  GetDeliverFee(
      this.key, this.origin, this.destination, this.weight, this.courier)
      : super([key, origin, destination, weight, courier]);
}
