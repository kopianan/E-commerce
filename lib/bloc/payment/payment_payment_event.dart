import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PaymentPaymentEvent extends Equatable {
  PaymentPaymentEvent([List props = const <dynamic>[]]) : super(props);
}

class GetArBalanceAsync extends PaymentPaymentEvent {
  final String userId ;

  GetArBalanceAsync(this.userId): super([userId]);


}
