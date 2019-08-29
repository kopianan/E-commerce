import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:flutter/material.dart';
import 'package:spinner_input/spinner_input.dart';

class CartListItem extends StatefulWidget {
  final DataItemModel dataItemModel;
  CartListItem({this.dataItemModel});

  @override
  _CartListItemState createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  double spinner = 1;

  double priceAndItem= 0;
  @override
  void initState() {
    priceAndItem =  double.parse(widget.dataItemModel.itemPrice.toString());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
      DataItemModel data = widget.dataItemModel;
    return Container(
      child: ListView.builder(
        itemCount: 1,
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
                               'http://dev.erp.web.id:8080${data.pic}' ,
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
                          Text( data.itemName,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                          ),
                          SpinnerInput(
                            spinnerValue: spinner,
                            onChange: (newValue) {
                              setState(() {
                                spinner = newValue;
                                priceAndItem = spinner * double.parse(widget.dataItemModel.itemPrice);
                              });
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
                        icon: Icon(Icons.delete_forever),
                        onPressed: () {},
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Text(
                        'Rp. ${priceAndItem}',
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
    );
  }
}
