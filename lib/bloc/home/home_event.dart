import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const <dynamic>[]]) : super(props);
}

class HomeGetBanner extends HomeEvent{
    HomeGetBanner();
}

class HomeGetProduct extends HomeEvent{
  HomeGetProduct();
}
