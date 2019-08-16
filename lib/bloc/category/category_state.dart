import 'package:ecommerce_test/models/category_model.dart';
import 'package:ecommerce_test/models/data_banner_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryState extends Equatable {
  CategoryState([List props = const <dynamic>[]]) : super(props);
}

class InitialCategoryState extends CategoryState {}

class CategoryLoading extends CategoryState{}

class GetBannerSuccess extends CategoryState{
  final List<DataBannerModel> bannerList;
  GetBannerSuccess(this.bannerList) : super([bannerList]);
}

class GetAllCategorySuccess extends CategoryState{
  final List<CategoryModel> categories;
  GetAllCategorySuccess(this.categories) : super([categories]);
}

class GetAllCategoryByParentIDSuccess extends CategoryState{
final List<CategoryModel> categories;
final String subCategoryName;
  GetAllCategoryByParentIDSuccess(this.categories,this.subCategoryName) : super([categories,subCategoryName]);
}

class GetAllCategoryByParentIDFailed extends CategoryState{
 final String categoryId;
 final String description;
 GetAllCategoryByParentIDFailed(this.categoryId,this.description) : super([categoryId,description]);
}

class CategoryFailed extends CategoryState{
  final String errorMessage;
  CategoryFailed(this.errorMessage):super([errorMessage]);
}