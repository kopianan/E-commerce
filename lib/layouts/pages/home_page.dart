import 'package:ecommerce_test/bloc/bloc.dart';
import 'package:ecommerce_test/bloc/home/home_bloc.dart';
import 'package:ecommerce_test/bloc/home/home_event.dart';
import 'package:ecommerce_test/bloc/home/home_state.dart';
import 'package:ecommerce_test/data/backend_service.dart';
import 'package:ecommerce_test/data/cart_list_data.dart';
import 'package:ecommerce_test/layouts/master_pages/home.dart';
import 'package:ecommerce_test/layouts/master_pages/subcategory_copy.dart';
import 'package:ecommerce_test/layouts/widgets/banner_slider.dart';
import 'package:ecommerce_test/layouts/widgets/detail_item.dart';
import 'package:ecommerce_test/layouts/widgets/item_list.dart';
import 'package:ecommerce_test/models/category_model.dart';
import 'package:ecommerce_test/models/data_banner_model.dart';
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        builder: (context) => HomeBloc(),
        child: HomePageChild(),
      ),
    );
  }
}

class HomePageChild extends StatefulWidget {
  const HomePageChild({
    Key key,
  }) : super(key: key);

  @override
  _HomePageChildState createState() => _HomePageChildState();
}

class _HomePageChildState extends State<HomePageChild> {
  List<DataBannerModel> banners = List<DataBannerModel>();
  List<DataItemModel> products = List<DataItemModel>();
  static const int PAGE_SIZE = 6;

  final categoryBloc = CategoryBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocListener(
        bloc: BlocProvider.of<HomeBloc>(context),
        listener: (BuildContext context, HomeState state) async {
          if (state is HomeFailed) {
            Toast.show("Home Failed!", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }

          if (state is HomeGetProductSuccess) {
            products = state.productList;
          }

          if (state is HomeGetBannerSuccess) {
            banners = state.bannerList;
          }
        },
        child: BlocBuilder(
            bloc: BlocProvider.of<HomeBloc>(context),
            builder: (BuildContext context, HomeState state) {
              if (state is InitialHomeState) {
                return buildInitial(context);
              } else if (state is HomeLoading) {
                return buildLoading();
              } else if (state is HomeGetBannerSuccess) {
                return buildLayout(context);
              } else {
                return buildLayout(context);
              }
            }),
      ),
    );
  }

  Widget buildInitial(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    products.add(DataItemModel());
    banners.add(DataBannerModel());
    homeBloc.dispatch(HomeGetBanner());
    homeBloc.dispatch(HomeGetProduct());
    return buildLayout(context);
  }

  Widget buildLoading() {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildLayout(
    BuildContext context,
  ) {
    return Consumer<CartListData>(
      builder: (context, listData, _) => Container(
        width: double.infinity,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new BannerSlider(listData: banners),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Kategori Belanja",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            "Lihat Kategori Lainnya",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                    BlocListener<CategoryBloc, CategoryState>(
                      bloc: categoryBloc,
                      listener:
                          (BuildContext context, CategoryState state) async {
                        if (state is GetAllCategoryByParentIdEnd) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemList(
                                      state.categoryId, state.categoryDesc)));
                        }

                        if (state is GetAllCategoryByParentIdSuccess) {
                          listData.addCategoryList(state.categories);
                          listData
                              .addHistoryCategoryModel(state.prevCategoryModel);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubCategoryCopy()));
                        }
                      },
                      child: BlocBuilder<CategoryBloc, CategoryState>(
                        bloc: categoryBloc,
                        builder: (BuildContext context, CategoryState state) {
                          if (state is InitialCategoryState) {
                            return buildCategoryContentBloc();
                          } else if (state is CategoryLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else
                            return buildCategoryContentBloc();
                        },
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "Promosi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                    Row(
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: const EdgeInsets.all(10),
                            child: Image.asset('assets/banner2.png')),
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: const EdgeInsets.all(10),
                            child: Image.asset('assets/banner3.png')),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "Rekomendasi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                  ],
                ),
              ]),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(10.0),
              sliver: PagewiseSliverGrid.count(
                  pageSize: 6,
                  crossAxisCount: 2,
                  childAspectRatio: 9 / 16,
                  itemBuilder: _itemBuilder,
                  pageFuture: (pageIndex) => BackendService.getDataItem(
                      pageIndex * PAGE_SIZE, PAGE_SIZE)),
            )
          ],
        ),
      ),
    );
  }

  Container buildCategoryContentBloc() {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildCategoryBelanja(CategoryModel(
                  description: "SPREI",
                  displayStore: "",
                  internalCode: "",
                  kategoriCode: "",
                  kategoriId: "140513827227129993761",
                  parentId: "",
                  picture: "")),
              buildCategoryBelanja(CategoryModel(
                  description: "Bed Cover",
                  displayStore: "",
                  internalCode: "",
                  kategoriCode: "",
                  kategoriId: "140513827206829878796",
                  parentId: "",
                  picture: "")),
              buildCategoryBelanja(CategoryModel(
                  description: "Selimut",
                  displayStore: "",
                  internalCode: "",
                  kategoriCode: "",
                  kategoriId: "140513827206829878796",
                  parentId: "",
                  picture: "")),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildCategoryBelanja(CategoryModel(
                  description: "Sarung",
                  displayStore: "",
                  internalCode: "",
                  kategoriCode: "",
                  kategoriId: "140513827228730006610",
                  parentId: "",
                  picture: "")),
              buildCategoryBelanja(CategoryModel(
                  description: "Kain Panjang",
                  displayStore: "",
                  internalCode: "",
                  kategoriCode: "",
                  kategoriId: "140513827217029938545",
                  parentId: "",
                  picture: "")),
              buildCategoryBelanja(CategoryModel(
                  description: "Handuk",
                  displayStore: "",
                  internalCode: "",
                  kategoriCode: "",
                  kategoriId: "140513827212029907277",
                  parentId: "",
                  picture: "")),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCategoryBelanja(CategoryModel category) {
    return Consumer<CartListData>(
      builder:(context, listData, _)=> Expanded(
        child: Card(
          elevation: 2,
          child: InkWell(
            onTap: () {

              listData.clearCategoryListAll();
              listData.clearHistoryCategoryModelAll();
              categoryBloc.dispatch(GetCategoryByParentId(
                  parentId: category.kategoriId, prevCategory: category));
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
              alignment: Alignment.center,
              child: Text(
                "${category.description}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(context, DataItemModel entry, _) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailItem(entry)),
        );
      },
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: FadeInImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "http://datacloud.erp.web.id:8081${entry.pic}"),
                placeholder: AssetImage('assets/broken_image.png'),
              ),
              height: 220.0,
              width: MediaQuery.of(context).size.width / 2.2,
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    entry.itemName,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Rp. ${entry.itmPriceFmt}',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "",
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
