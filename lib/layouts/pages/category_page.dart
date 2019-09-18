import 'package:ecommerce_test/bloc/category/category_bloc.dart';
import 'package:ecommerce_test/bloc/category/category_event.dart';
import 'package:ecommerce_test/bloc/category/category_state.dart';
import 'package:ecommerce_test/data/cart_list_data.dart';
import 'package:ecommerce_test/layouts/master_pages/subcategory_copy.dart';
import 'package:ecommerce_test/layouts/widgets/item_list.dart';
import 'package:ecommerce_test/models/data_banner_model.dart';
import 'package:ecommerce_test/models/category_model.dart';
import 'package:ecommerce_test/layouts/widgets/banner_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget {
  Category({Key key}) : super(key: key);

  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  // String baseUrl = "http://datacloud.erp.web.id:8081";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoryChild(),
    );
  }
}

class CategoryChild extends StatefulWidget {
  const CategoryChild({
    Key key,
  }) : super(key: key);

  @override
  _CategoryChildState createState() => _CategoryChildState();
}

class _CategoryChildState extends State<CategoryChild> {
  List<DataBannerModel> banners = List<DataBannerModel>();
  List<CategoryModel> categories = List<CategoryModel>();
  final _btnBloc = new CategoryBloc();

  @override
  Widget build(BuildContext context) {
    return Consumer<CartListData>(
      builder: (context, listData, _) => Container(
          child: BlocListener(
              bloc: _btnBloc,
              listener: (BuildContext context, CategoryState state) async {
                listData.historyCategoryModel.clear() ;
                listData.listOfLIstCategory.clear();
                if (state is GetAllCategorySuccess) {
                  categories = state.categories;
                }

                if (state is GetBannerSuccess) {
                  banners = state.bannerList;
                }

                if (state is GetAllCategoryByParentIDFailed) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ItemList(state.categoryId, state.description),
                    ),
                  );
                }

                if (state is GetAllCategoryByParentIdEnd) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ItemList(state.categoryId, state.categoryDesc)));
                }

                if (state is GetAllCategoryByParentIdSuccess) {
                  listData.addCategoryList(state.categories);
                  listData.addHistoryCategoryModel(state.prevCategoryModel);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubCategoryCopy(
                                prevCategory: state.prevCategoryModel,
                                categoryList: state.categories,
                              )));
                }
              },
              child: BlocBuilder(
                  bloc: _btnBloc,
                  builder: (BuildContext context, CategoryState state) {
                    if (state is InitialCategoryState) {
                      return buildInitial(context);
                    } else if (state is CategoryLoading) {
                      return buildLoading();
                    } else if (state is GetAllCategoryByParentIDSuccess) {
                      return buildLoading();
                    } else if (state is GetAllCategoryByParentIDFailed) {
                      return buildLayout(context);
                    } else {
                      return buildLayout(context);
                    }
                  }))),
    );
  }

  Widget buildInitial(BuildContext context) {
    banners.add(DataBannerModel());
    categories.add(CategoryModel());
    _btnBloc.dispatch(GetBanners());
    _btnBloc.dispatch(GetAllCategory());
    return buildLayout(context);
  }

  Widget buildLoading() {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildLayout(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          BannerSlider(
            listData: banners,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 7 / 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: InkWell(
                    onTap: () {
                      _btnBloc.dispatch(GetCategoryByParentId(
                          parentId: categories[index].kategoriId,
                          prevCategory: categories[index]));
                    },
                    child: Card(
                      elevation: 4,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: (categories[index].description ==null)?Text(""):
                              Text(
                                categories[index].description,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
