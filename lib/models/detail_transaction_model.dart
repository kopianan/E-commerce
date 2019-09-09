class DetailTransactionModel {
  String salesOrderDetailId;
  String salesOrderId;
  String indexNo;
  String itemId;
  String itemCode;
  String itemName;
  String description;
  String unitId;
  String unitCode;
  String taxId;
  String taxAmount;
  String subTotalTax;
  String discount;
  String subTotalDisc;
  String qty;
  String qtyBase;
  String itemPrice;
  String subTotal;
  String costPerUnit;
  String deliveredQty;
  String closed;
  String projectId;
  String departmentId;
  String employeeId;
  String quotationId;
  String quotationDetailId;

  DetailTransactionModel(
      {this.salesOrderDetailId,
        this.salesOrderId,
        this.indexNo,
        this.itemId,
        this.itemCode,
        this.itemName,
        this.description,
        this.unitId,
        this.unitCode,
        this.taxId,
        this.taxAmount,
        this.subTotalTax,
        this.discount,
        this.subTotalDisc,
        this.qty,
        this.qtyBase,
        this.itemPrice,
        this.subTotal,
        this.costPerUnit,
        this.deliveredQty,
        this.closed,
        this.projectId,
        this.departmentId,
        this.employeeId,
        this.quotationId,
        this.quotationDetailId});

  DetailTransactionModel.fromJson(Map<String, dynamic> json) {
    salesOrderDetailId = json['sales_order_detail_id'];
    salesOrderId = json['sales_order_id'];
    indexNo = json['index_no'];
    itemId = json['item_id'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    description = json['description'];
    unitId = json['unit_id'];
    unitCode = json['unit_code'];
    taxId = json['tax_id'];
    taxAmount = json['tax_amount'];
    subTotalTax = json['sub_total_tax'];
    discount = json['discount'];
    subTotalDisc = json['sub_total_disc'];
    qty = json['qty'];
    qtyBase = json['qty_base'];
    itemPrice = json['item_price'];
    subTotal = json['sub_total'];
    costPerUnit = json['cost_per_unit'];
    deliveredQty = json['delivered_qty'];
    closed = json['closed'];
    projectId = json['project_id'];
    departmentId = json['department_id'];
    employeeId = json['employee_id'];
    quotationId = json['quotation_id'];
    quotationDetailId = json['quotation_detail_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sales_order_detail_id'] = this.salesOrderDetailId;
    data['sales_order_id'] = this.salesOrderId;
    data['index_no'] = this.indexNo;
    data['item_id'] = this.itemId;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['description'] = this.description;
    data['unit_id'] = this.unitId;
    data['unit_code'] = this.unitCode;
    data['tax_id'] = this.taxId;
    data['tax_amount'] = this.taxAmount;
    data['sub_total_tax'] = this.subTotalTax;
    data['discount'] = this.discount;
    data['sub_total_disc'] = this.subTotalDisc;
    data['qty'] = this.qty;
    data['qty_base'] = this.qtyBase;
    data['item_price'] = this.itemPrice;
    data['sub_total'] = this.subTotal;
    data['cost_per_unit'] = this.costPerUnit;
    data['delivered_qty'] = this.deliveredQty;
    data['closed'] = this.closed;
    data['project_id'] = this.projectId;
    data['department_id'] = this.departmentId;
    data['employee_id'] = this.employeeId;
    data['quotation_id'] = this.quotationId;
    data['quotation_detail_id'] = this.quotationDetailId;
    return data;
  }
}
