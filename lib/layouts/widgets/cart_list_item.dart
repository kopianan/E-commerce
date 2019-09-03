import 'package:ecommerce_test/data/cart_list_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spinner_input/spinner_input.dart';

class CartListItem extends StatelessWidget {
  final formatter = new NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    return Consumer<CartListData>(
      builder: (context, data, _) => Container(
        child: ListView.builder(
          itemCount: data.cartListItem.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Card(
                child: Row(
                  children: <Widget>[
                    SafeArea(
                        top: false,
                        bottom: false,
                        minimum: const EdgeInsets.only(
                            left: 16, top: 8, bottom: 8, right: 8),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.network(
                                'http://dev.erp.web.id:8080${data.cartListItem[index].pic}',
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data.cartListItem[index].itemName,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8),
                            ),
                            SpinnerInput(
                              spinnerValue:double.parse(data.cartListItem[index].boughQuantity),
                              onChange: (newValue) {
                                data.updateQuantity(index, newValue.toString());
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.clear, color: Colors.red,),
                          onPressed: () {
                            data.clearItemOfList( data.cartListItem[index]);
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                        Text(
                          'Rp. ${formatter.format(int.parse(data.cartListItem[index].boughQuantity.replaceAll('.', "")) * int.parse(data.cartListItem[index].itmPriceFmt.replaceAll(',', "")) )}',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
