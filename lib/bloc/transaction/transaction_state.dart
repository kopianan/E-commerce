import 'package:ecommerce_test/models/transaction_response.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TransactionState extends Equatable {
  TransactionState([List props = const <dynamic>[]]) : super(props);
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState{}

class TransactionSuccess extends TransactionState{
  final TransactionResponse transResp ;

  TransactionSuccess(this.transResp):super([transResp]);

}

class TransactionFailed extends TransactionState{
  final String error ;

  TransactionFailed(this.error):super([error]);

}
