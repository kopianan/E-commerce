class AllTransactionListModel {
  String salesOrderId;
  String transactionStatus;
  String salesOrderNo;
  String transactionDate;
  String dueDate;
  String customerId;
  String customerName;
  String customerPoNo;
  String customerPoDate;
  String totalQty;
  String totalAmount;
  String totalDiscountPct;
  String totalDiscount;
  String totalFee;
  String totalTax;
  String remark;
  String paymentTypeId;
  String paymentTermId;
  String currencyId;
  String currencyRate;
  String locationId;
  String printTimes;
  String userName;
  String confirmBy;
  String confirmDate;
  String downPayment;
  String shipTo;
  String shipDate;
  String bankId;
  String bankIssuer;
  String dpAccountId;
  String dpDueDate;
  String referenceNo;
  String cashFlowTypeId;
  String salesId;
  String courierId;
  String fobId;
  String estimatedFreight;
  String isTaxable;
  String isInclusiveTax;
  String fiscalRate;
  String freightAccountId;
  String isInclusiveFreight;
  String cancelBy;
  String cancelDate;

  AllTransactionListModel(
      {this.salesOrderId,
        this.transactionStatus,
        this.salesOrderNo,
        this.transactionDate,
        this.dueDate,
        this.customerId,
        this.customerName,
        this.customerPoNo,
        this.customerPoDate,
        this.totalQty,
        this.totalAmount,
        this.totalDiscountPct,
        this.totalDiscount,
        this.totalFee,
        this.totalTax,
        this.remark,
        this.paymentTypeId,
        this.paymentTermId,
        this.currencyId,
        this.currencyRate,
        this.locationId,
        this.printTimes,
        this.userName,
        this.confirmBy,
        this.confirmDate,
        this.downPayment,
        this.shipTo,
        this.shipDate,
        this.bankId,
        this.bankIssuer,
        this.dpAccountId,
        this.dpDueDate,
        this.referenceNo,
        this.cashFlowTypeId,
        this.salesId,
        this.courierId,
        this.fobId,
        this.estimatedFreight,
        this.isTaxable,
        this.isInclusiveTax,
        this.fiscalRate,
        this.freightAccountId,
        this.isInclusiveFreight,
        this.cancelBy,
        this.cancelDate});

  AllTransactionListModel.fromJson(Map<String, dynamic> json) {
    salesOrderId = json['sales_order_id'];
    transactionStatus = json['transaction_status'];
    salesOrderNo = json['sales_order_no'];
    transactionDate = json['transaction_date'];
    dueDate = json['due_date'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerPoNo = json['customer_po_no'];
    customerPoDate = json['customer_po_date'];
    totalQty = json['total_qty'];
    totalAmount = json['total_amount'];
    totalDiscountPct = json['total_discount_pct'];
    totalDiscount = json['total_discount'];
    totalFee = json['total_fee'];
    totalTax = json['total_tax'];
    remark = json['remark'];
    paymentTypeId = json['payment_type_id'];
    paymentTermId = json['payment_term_id'];
    currencyId = json['currency_id'];
    currencyRate = json['currency_rate'];
    locationId = json['location_id'];
    printTimes = json['print_times'];
    userName = json['user_name'];
    confirmBy = json['confirm_by'];
    confirmDate = json['confirm_date'];
    downPayment = json['down_payment'];
    shipTo = json['ship_to'];
    shipDate = json['ship_date'];
    bankId = json['bank_id'];
    bankIssuer = json['bank_issuer'];
    dpAccountId = json['dp_account_id'];
    dpDueDate = json['dp_due_date'];
    referenceNo = json['reference_no'];
    cashFlowTypeId = json['cash_flow_type_id'];
    salesId = json['sales_id'];
    courierId = json['courier_id'];
    fobId = json['fob_id'];
    estimatedFreight = json['estimated_freight'];
    isTaxable = json['is_taxable'];
    isInclusiveTax = json['is_inclusive_tax'];
    fiscalRate = json['fiscal_rate'];
    freightAccountId = json['freight_account_id'];
    isInclusiveFreight = json['is_inclusive_freight'];
    cancelBy = json['cancel_by'];
    cancelDate = json['cancel_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sales_order_id'] = this.salesOrderId;
    data['transaction_status'] = this.transactionStatus;
    data['sales_order_no'] = this.salesOrderNo;
    data['transaction_date'] = this.transactionDate;
    data['due_date'] = this.dueDate;
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['customer_po_no'] = this.customerPoNo;
    data['customer_po_date'] = this.customerPoDate;
    data['total_qty'] = this.totalQty;
    data['total_amount'] = this.totalAmount;
    data['total_discount_pct'] = this.totalDiscountPct;
    data['total_discount'] = this.totalDiscount;
    data['total_fee'] = this.totalFee;
    data['total_tax'] = this.totalTax;
    data['remark'] = this.remark;
    data['payment_type_id'] = this.paymentTypeId;
    data['payment_term_id'] = this.paymentTermId;
    data['currency_id'] = this.currencyId;
    data['currency_rate'] = this.currencyRate;
    data['location_id'] = this.locationId;
    data['print_times'] = this.printTimes;
    data['user_name'] = this.userName;
    data['confirm_by'] = this.confirmBy;
    data['confirm_date'] = this.confirmDate;
    data['down_payment'] = this.downPayment;
    data['ship_to'] = this.shipTo;
    data['ship_date'] = this.shipDate;
    data['bank_id'] = this.bankId;
    data['bank_issuer'] = this.bankIssuer;
    data['dp_account_id'] = this.dpAccountId;
    data['dp_due_date'] = this.dpDueDate;
    data['reference_no'] = this.referenceNo;
    data['cash_flow_type_id'] = this.cashFlowTypeId;
    data['sales_id'] = this.salesId;
    data['courier_id'] = this.courierId;
    data['fob_id'] = this.fobId;
    data['estimated_freight'] = this.estimatedFreight;
    data['is_taxable'] = this.isTaxable;
    data['is_inclusive_tax'] = this.isInclusiveTax;
    data['fiscal_rate'] = this.fiscalRate;
    data['freight_account_id'] = this.freightAccountId;
    data['is_inclusive_freight'] = this.isInclusiveFreight;
    data['cancel_by'] = this.cancelBy;
    data['cancel_date'] = this.cancelDate;
    return data;
  }
}
