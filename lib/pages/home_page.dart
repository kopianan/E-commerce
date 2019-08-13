import 'package:ecommerce_test/bloc/home/home_bloc.dart';
import 'package:ecommerce_test/bloc/home/home_event.dart';
import 'package:ecommerce_test/bloc/home/home_state.dart';
import 'package:ecommerce_test/models/data_banner_model.dart';
import 'package:ecommerce_test/widgets/banner_slider.dart';
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
  // List<DataBannerModel> listData;
  // List<DataItemModel> itemData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        builder: (context) => HomeBloc(),
        child: HomePageChild(),
      ),
    );
  }
}

class HomePageChild extends StatelessWidget {
  const HomePageChild({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocListener(
        bloc: BlocProvider.of<HomeBloc>(context),
        listener: (BuildContext context, HomeState state) async {
          if (state is HomeFailed) {
            Toast.show("Home Failed!", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
                return buildHomeBanner(context,state.bannerList);
              } 
              else if (state is HomeGetProductSuccess) {
                return buildHomeProduct(state.productList);
              } 
              else return buildInitial(context);
            }),
      ),
    );
  }

  Widget buildInitial(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.dispatch(HomeGetBanner());
    // homeBloc.dispatch(HomeGetProduct());

    return Scaffold(
      body: Center(
        child: Text("Loading Home"),
      ),
    );
  }

  Widget buildLoading() {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildHomeBanner(BuildContext context, List<DataBannerModel> banners) {
    return Scaffold(
      body: buildLayout(context,banners),
    );
  }

  Widget buildHomeProduct(List<DataItemModel> products) {
    return Scaffold(
      body: Center(child: Text(products.first.itemName)),
    );
   
  }

  Widget buildLayout(
    BuildContext context,
    List<DataBannerModel> banners,
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
          // SliverGrid(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2, childAspectRatio: 9 / 12),
          //   delegate: SliverChildListDelegate(
          //     products
          //         .map(
          //           (data) => Container(
          //             child: InkWell(
          //               onTap: () {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => DetailItem(data)),
          //                 );
          //               },
          //               child: Card(
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: <Widget>[
          //                     FadeInImage(
          //                         image: NetworkImage(
          //                             "http://datacloud.erp.web.id:8081${data.pic}"),
          //                         placeholder:
          //                             AssetImage('assets/banner2.png')),
          //                     // Image.network(
          //                     //     "http://datacloud.erp.web.id:8081${data.pic}"),
          //                     Container(
          //                       margin: EdgeInsets.all(10),
          //                       child: Column(
          //                         children: <Widget>[
          //                           Row(
          //                             children: <Widget>[
          //                               Image.asset('assets/SALE.png'),
          //                               Flexible(
          //                                 child: Text(
          //                                   data.itemName,
          //                                   textAlign: TextAlign.left,
          //                                   overflow: TextOverflow.ellipsis,
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                           Row(
          //                             children: <Widget>[
          //                               Container(
          //                                   margin: EdgeInsets.only(right: 5),
          //                                   child: Text(
          //                                     data.itmPriceFmt,
          //                                     style: TextStyle(
          //                                         color: Colors.grey,
          //                                         decoration: TextDecoration
          //                                             .lineThrough),
          //                                   )),
          //                               Container(
          //                                   child: Text(
          //                                 data.itmPriceFmt,
          //                                 style: TextStyle(
          //                                     color: Colors.purple,
          //                                     fontWeight: FontWeight.bold),
          //                               )),
          //                             ],
          //                           )
          //                         ],
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //         )
          //         .toList(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
