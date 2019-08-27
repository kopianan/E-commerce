import 'package:ecommerce_test/models/sales_transaction_detail_model.dart';

class SalesTransactionModel {
  List<SalesTransactionDetailModel> salesTrans;

  SalesTransactionModel({this.salesTrans});

  SalesTransactionModel.fromJson(Map<String, dynamic> json) {
    if (json['sales_trans'] != null) {
      salesTrans = new List<SalesTransactionDetailModel>();
      json['sales_trans'].forEach((v) {
        salesTrans.add(new SalesTransactionDetailModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.salesTrans != null) {
      data['sales_trans'] = this.salesTrans.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

