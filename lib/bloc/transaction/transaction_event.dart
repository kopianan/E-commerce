import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TransactionEvent extends Equatable {
  TransactionEvent([List props = const <dynamic>[]]) : super(props);
}

class DoTransaction extends TransactionEvent{
  final String url ;

  DoTransaction(this.url): super([url]);
}
