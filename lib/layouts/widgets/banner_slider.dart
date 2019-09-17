import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_test/models/data_banner_model.dart';
import 'package:flutter/material.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({
    Key key,
    @required this.listData,
  }) : super(key: key);

  final List<DataBannerModel> listData;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      height: 150.0,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 5),
      items: [
        FadeInImage(image: NetworkImage('http://datacloud.erp.web.id:8081/${listData[0].picture}'), placeholder: AssetImage('assets/SALE.png'), fit: BoxFit.fill,),
        // Image.network('http://datacloud.erp.web.id:8081/${listData[0].picture}'),
        Image.asset('assets/banner3.png')
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(color: Colors.white),
              child: i,
            );
          },
        );
      }).toList(),
    );
  }
}
