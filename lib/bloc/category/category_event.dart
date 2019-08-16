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
  GetAllCategory();
}

class GetAllCategoryByParentID extends CategoryEvent{
  final String parentID;
  final String description;
  GetAllCategoryByParentID(this.parentID, this.description);
}
