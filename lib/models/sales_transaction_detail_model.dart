import 'package:ecommerce_test/models/bought_item_model.dart';

class SalesTransactionDetailModel {
  String transNo;
  String transType;
  String location;
  String transDt;
  String customer;
  String createBy;
  String remark;
  String pmttype;
  String pmtterm;
  List<BoughItem> details;

  SalesTransactionDetailModel(
      {this.transNo,
        this.transType,
        this.location,
        this.transDt,
        this.customer,
        this.createBy,
        this.remark,
        this.pmttype,
        this.pmtterm,
        this.details});

  SalesTransactionDetailModel.fromJson(Map<String, dynamic> json) {
    transNo = json['trans_no'];
    transType = json['trans_type'];
    location = json['location'];
    transDt = json['trans_dt'];
    customer = json['customer'];
    createBy = json['create_by'];
    remark = json['remark'];
    pmttype = json['pmttype'];
    pmtterm = json['pmtterm'];
    if (json['details'] != null) {
      details = new List<BoughItem>();
      json['details'].forEach((v) {
        details.add(new BoughItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trans_no'] = this.transNo;
    data['trans_type'] = this.transType;
    data['location'] = this.location;
    data['trans_dt'] = this.transDt;
    data['customer'] = this.customer;
    data['create_by'] = this.createBy;
    data['remark'] = this.remark;
    data['pmttype'] = this.pmttype;
    data['pmtterm'] = this.pmtterm;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

