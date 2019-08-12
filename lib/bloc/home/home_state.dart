import 'package:ecommerce_test/models/data_banner_model.dart';
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState([List props = const <dynamic>[]]) : super(props);
}

class InitialHomeState extends HomeState {}

class HomeLoading extends HomeState{}

class HomeGetBannerSuccess extends HomeState{
  final List<DataBannerModel> bannerList;
  HomeGetBannerSuccess(this.bannerList) : super([bannerList]);
}

class HomeGetProductSuccess extends HomeState{
  final List<DataItemModel> productList;
  HomeGetProductSuccess(this.productList) : super([productList]);
}

class HomeFailed extends HomeState{
  final String errorMessage;
  HomeFailed(this.errorMessage):super([errorMessage]);
}
