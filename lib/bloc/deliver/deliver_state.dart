import 'package:ecommerce_test/models/list_of_ongkir_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeliverState {}

class InitialDeliverState extends DeliverState {}

class GetAllDeliverPriceLoading extends DeliverState{}

class GetAllDeliverPriceSuccess extends DeliverState{
  final List<ListOfOngkirModel> listOfOngkir ;
  GetAllDeliverPriceSuccess(this.listOfOngkir);
}

class GetAllDeliverPriceFailed extends DeliverState{
  final String erroMessage ;
  GetAllDeliverPriceFailed(this.erroMessage);

}
