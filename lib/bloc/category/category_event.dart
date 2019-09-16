import 'package:ecommerce_test/models/category_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryEvent extends Equatable {
  CategoryEvent([List props = const <dynamic>[]]) : super(props);
}

class GetBanners extends CategoryEvent{
  GetBanners();
}

class GetAllCategory extends CategoryEvent{
  final String parentId ;
  final CategoryModel prevCategory;

  GetAllCategory({this.parentId, this.prevCategory}):super([parentId, prevCategory]);
}

class GetAllCategoryByParentID extends CategoryEvent{
  final String parentID;
  final String description;
  GetAllCategoryByParentID(this.parentID, this.description);
}

class GetCategoryByParentId extends CategoryEvent{
  final String parentId ;
  final CategoryModel prevCategory;

  GetCategoryByParentId({this.parentId, this.prevCategory}):super([parentId, prevCategory]);


}
