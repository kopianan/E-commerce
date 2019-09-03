import 'package:ecommerce_test/bloc/category/category_bloc.dart';
import 'package:ecommerce_test/bloc/category/category_event.dart';
import 'package:ecommerce_test/bloc/category/category_state.dart';
import 'package:ecommerce_test/layouts/master_pages/subcategory.dart';
import 'package:ecommerce_test/layouts/widgets/item_list.dart';
import 'package:ecommerce_test/models/data_banner_model.dart';
import 'package:ecommerce_test/models/category_model.dart';
import 'package:ecommerce_test/layouts/widgets/banner_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Category extends StatefulWidget {
  Category({Key key}) : super(key: key);

  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  // String baseUrl = "http://datacloud.erp.web.id:8081";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      builder: (context) => CategoryBloc(),
      child: CategoryChild(),
    ));
  }
}

//////////////////
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocListener(
            bloc: BlocProvider.of<CategoryBloc>(context),
            listener: (BuildContext context, CategoryState state) async {
              //coding

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

              if (state is GetAllCategoryByParentIDSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                       builder: (context) => SubCategory(subCategoryName: state.subCategoryName, categories: state.categories,)
                  ),
                );
              }
            },
            child: BlocBuilder(
              bloc: BlocProvider.of<CategoryBloc>(context),
              builder: (BuildContext context, CategoryState state) {
                if (state is InitialCategoryState) {
                  return buildInitial(context);
                } else if (state is CategoryLoading) {
                  return buildLoading();
                } else if (state is GetAllCategoryByParentIDSuccess){
                  return buildLoading();
                } else if(state is GetAllCategoryByParentIDFailed){
                  return buildLayout(context);
                }else {
                  return buildLayout(context);}
              }
            )));
  }

  Widget buildInitial(BuildContext context) {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
    banners.add(DataBannerModel());
    categories.add(CategoryModel());
    categoryBloc.dispatch(GetBanners());
    categoryBloc.dispatch(GetAllCategory());
    return buildLayout(context);
  }

  Widget buildLoading() {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildLayout(BuildContext context) {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
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
                      categoryBloc.dispatch(GetAllCategoryByParentID(
                          categories[index].kategoriId, categories[index].description
                          ));
                  
                    },
                    child: Card(
                      elevation: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                categories[index].description,
                                textAlign: TextAlign.center,
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
