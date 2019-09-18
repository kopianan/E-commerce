import 'package:ecommerce_test/models/CityModel.dart';
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
//Get All Province And City Data

class GetAllProvinceAndCitySuccess extends DeliverState {
  final CityModel listProvinceAndCity ;
  GetAllProvinceAndCitySuccess(this.listProvinceAndCity);

}

class GetAllProvinceAndCityFailed extends DeliverState {
  final String errorMessage ;
  GetAllProvinceAndCityFailed(this.errorMessage);
}

class GetAllProvinceAndCityLoading extends DeliverState {}