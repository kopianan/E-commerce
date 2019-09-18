import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_test/bloc/bloc.dart';
import 'package:ecommerce_test/models/data_banner_model.dart';
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeGetBanner) {
      yield HomeLoading();
      final banners = await _getBanner();
      if (banners == null) {
        yield HomeFailed("No Banners Loaded");
      } else {
        yield HomeGetBannerSuccess(banners);
      }
    }

    if (event is HomeGetProduct) {
      yield HomeLoading();
      final products = await _getDataItem();
      if (products == null) {
        yield HomeFailed("No Products Loaded");
      } else {
        yield HomeGetProductSuccess(products);
      }
    }
  }
}

Future<List<DataBannerModel>> _getBanner() async {
  http.Response response;
  response = await http.get(
      "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,SPGBanner.vm");


  if (response.statusCode == 200) {
    List responseJson = await json.decode(response.body);
    final data =
        responseJson.map((m) => new DataBannerModel.fromJson(m)).toList();
    return data.cast();
  } else {
    return null;
  }
}

Future<List<DataItemModel>> _getDataItem() async {
  http.Response response;
  response = await http.get(
      "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,SPGApps.vm?cmd=2&loccode=GODM&kategoriid=140513828168532755861&limit=10&offset=4");

  if (response.statusCode == 200) {
    List responseJson = await json.decode(response.body);
    final data =
        responseJson.map((m) => new DataItemModel.fromJson(m)).toList();
    return data.cast();
  } else {
    return null;
  }
}
