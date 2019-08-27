
import 'package:flutter/foundation.dart';

class BoughItem {
  String itemCode;
  String itemId;
  String qty;
  String unit;
  String price;
  String tax;
  String discount;

  BoughItem(
      {this.itemCode,
        this.itemId,
        this.qty,
        this.unit,
        this.price,
        this.tax,
        this.discount});

  BoughItem.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemId = json['item_id'];
    qty = json['qty'];
    unit = json['unit'];
    price = json['price'];
    tax = json['tax'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_code'] = this.itemCode;
    data['item_id'] = this.itemId;
    data['qty'] = this.qty;
    data['unit'] = this.unit;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    return data;
  }
}
