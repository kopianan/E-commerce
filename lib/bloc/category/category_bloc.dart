import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_test/models/category_model.dart';
import 'package:ecommerce_test/models/data_banner_model.dart';
import '../bloc.dart';
import 'package:http/http.dart' as http;

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  @override
  CategoryState get initialState => InitialCategoryState();

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is GetBanners) {
      yield CategoryLoading();
      final banners = await _getBanner();
      if (banners != null) {
        yield GetBannerSuccess(banners);
      } else {
        yield CategoryFailed("Get banners failed.");
      }
    }

    if (event is GetAllCategory) {
      yield CategoryLoading();
      final categories = await _getCategory();
      if (categories != null) {
        yield GetAllCategorySuccess(categories);
      } else {
        yield GetAllCategoryByParentIdEnd(event.prevCategory.kategoriId, event.prevCategory.description);
      }
    }

    if (event is GetAllCategoryByParentID) {
      yield CategoryLoading();
      final categories = await _getCategoryByParentId(event.parentID);
      if (categories != null || categories.length > 0) {
        yield GetAllCategoryByParentIDSuccess(categories,event.description);
      } else {
        yield GetAllCategoryByParentIDFailed(event.parentID,event.description);
      }
    }

    if(event is GetCategoryByParentId){
      yield CategoryLoading();
      final ctegories = await _getCateogryByParentId(event.parentId);
      if(ctegories != null  ) {
        yield GetAllCategoryByParentIdSuccess(
            categories: ctegories, prevCategoryModel: event.prevCategory);
      }else{
        yield GetAllCategoryByParentIdEnd(event.prevCategory.kategoriId, event.prevCategory.description);
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


  Future<List<CategoryModel>> _getCategory() async {
    http.Response response;
    response = await http.get(
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,KategoriData.vm");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

      List responseJson = await json.decode(response.body);

      final data =
          responseJson.map((md) => new CategoryModel.fromJson(md)).toList();

      final filteredData = data.where((f) => f.parentId == "").toList();

      return filteredData.cast();
    } else {
      return null;
    }
  }

  Future<List<CategoryModel>> _getCateogryByParentId(String parentId) async {
    http.Response response;
    response = await http.get(
        "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,KategoriData.vm?parent_id=$parentId");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

      List responseJson = await json.decode(response.body);

      final data =
          responseJson.map((md) => new CategoryModel.fromJson(md)).toList();

      if(data.length == 0){
        return null ;
      }else {
        return data.cast();
      }

    } else {
      return null;
    }
  }
}

Future<List<CategoryModel>> _getCategoryByParentId(String categoryId) async {
  http.Response response;
  response = await http.get(
      "http://datacloud.erp.web.id:8081/padadev18/weblayer/template/api,KategoriData.vm");

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON

    List responseJson = await json.decode(response.body);

    final data =
        responseJson.map((md) => new CategoryModel.fromJson(md)).toList();

    final filteredData = data.where((f) => f.parentId == categoryId).toList();

    return filteredData.cast();
  } else {
    return null;
  }
}
