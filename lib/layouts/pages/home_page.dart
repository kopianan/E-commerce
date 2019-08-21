import 'package:ecommerce_test/bloc/home/home_bloc.dart';
import 'package:ecommerce_test/bloc/home/home_event.dart';
import 'package:ecommerce_test/bloc/home/home_state.dart';
import 'package:ecommerce_test/layouts/widgets/detail_item.dart';
import 'package:ecommerce_test/models/data_banner_model.dart';
import 'package:ecommerce_test/layouts/widgets/banner_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Container(
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
                          "Lihat Ketegori Lainnya",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Text(
                              "Fashion Pria",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              "Fashion Pria",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              "Fashion Pria",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                      ],
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
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                crossAxisCount: 2, childAspectRatio: 9 / 14),
            delegate: SliverChildListDelegate(
              products
                  .map(
                    (data) => Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailItem(data)),
                          );
                        },
                        child: Card(
                          elevation: 4,
                            child: GridTile(
                                header: GridTileBar(
                                  trailing: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.favorite_border),
                                  ),
                                  title: Text(
                                    data.itemName,
                                    maxLines: 2,
                                  ),
                                  backgroundColor:
                                      Color.fromRGBO(105, 105, 105, 30),
                                ),
                                footer: GridTileBar(
                                  leading: Text(
                                    'Rp ${data.itmPriceFmt}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  backgroundColor:
                                      Color.fromRGBO(220, 220, 220, 10),
                                ),
                                child: FadeInImage(
                                  image: NetworkImage(
                                      "http://datacloud.erp.web.id:8081${data.pic}"),
                                  placeholder: AssetImage('assets/banner2.png'),
                                ))),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
