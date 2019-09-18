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
  String barcode;
  String itemSku;
  String itemSkuName;
  String vendorItemCode;
  String vendorItemName;
  String itemType;
  String kategoriId;
  String purchaseUnitId;
  String purchaseTaxId;
  String preferedVendorId;
  String minPrice;
  String isFixedPrice;
  String itemPicture;
  String lastPurchasePrice;
  String lastPurchaseCurr;
  String lastPurchaseRate;
  String profitMargin;
  String minimumStock;
  String reorderPoint;
  String maximumStock;
  String rackLocation;
  String warehouseId;
  String deliveryType;
  String itemStatusCodeId;
  String statusColor;
  String discountAmount;
  String createBy;
  String addDate;
  String updateDate;
  String lastAdjustment;
  String size;
  String color;
  String sizeUnit;
  String unitConversion;
  String manufacturer;
  String trackSerialNo;
  String trackBatchNo;
  String itemStatus;
  String inventoryAccount;
  String salesAccount;
  String salesReturnAccount;
  String itemDiscountAccount;
  String cogsAccount;
  String purchaseReturnAccount;
  String expenseAccount;
  String unbilledGoodsAccount;
  String isConsignment;
  String isDiscontinue;
  String displayStore;
  String displayDesc;
  String tags;
  String weight;
  String volume;
  String brand;

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
        this.quotationDetailId,
        this.barcode,
        this.itemSku,
        this.itemSkuName,
        this.vendorItemCode,
        this.vendorItemName,
        this.itemType,
        this.kategoriId,
        this.purchaseUnitId,
        this.purchaseTaxId,
        this.preferedVendorId,
        this.minPrice,
        this.isFixedPrice,
        this.itemPicture,
        this.lastPurchasePrice,
        this.lastPurchaseCurr,
        this.lastPurchaseRate,
        this.profitMargin,
        this.minimumStock,
        this.reorderPoint,
        this.maximumStock,
        this.rackLocation,
        this.warehouseId,
        this.deliveryType,
        this.itemStatusCodeId,
        this.statusColor,
        this.discountAmount,
        this.createBy,
        this.addDate,
        this.updateDate,
        this.lastAdjustment,
        this.size,
        this.color,
        this.sizeUnit,
        this.unitConversion,
        this.manufacturer,
        this.trackSerialNo,
        this.trackBatchNo,
        this.itemStatus,
        this.inventoryAccount,
        this.salesAccount,
        this.salesReturnAccount,
        this.itemDiscountAccount,
        this.cogsAccount,
        this.purchaseReturnAccount,
        this.expenseAccount,
        this.unbilledGoodsAccount,
        this.isConsignment,
        this.isDiscontinue,
        this.displayStore,
        this.displayDesc,
        this.tags,
        this.weight,
        this.volume,
        this.brand});

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
    barcode = json['barcode'];
    itemSku = json['item_sku'];
    itemSkuName = json['item_sku_name'];
    vendorItemCode = json['vendor_item_code'];
    vendorItemName = json['vendor_item_name'];
    itemType = json['item_type'];
    kategoriId = json['kategori_id'];
    purchaseUnitId = json['purchase_unit_id'];
    purchaseTaxId = json['purchase_tax_id'];
    preferedVendorId = json['prefered_vendor_id'];
    minPrice = json['min_price'];
    isFixedPrice = json['is_fixed_price'];
    itemPicture = json['item_picture'];
    lastPurchasePrice = json['last_purchase_price'];
    lastPurchaseCurr = json['last_purchase_curr'];
    lastPurchaseRate = json['last_purchase_rate'];
    profitMargin = json['profit_margin'];
    minimumStock = json['minimum_stock'];
    reorderPoint = json['reorder_point'];
    maximumStock = json['maximum_stock'];
    rackLocation = json['rack_location'];
    warehouseId = json['warehouse_id'];
    deliveryType = json['delivery_type'];
    itemStatusCodeId = json['item_status_code_id'];
    statusColor = json['status_color'];
    discountAmount = json['discount_amount'];
    createBy = json['create_by'];
    addDate = json['add_date'];
    updateDate = json['update_date'];
    lastAdjustment = json['last_adjustment'];
    size = json['size'];
    color = json['color'];
    sizeUnit = json['size_unit'];
    unitConversion = json['unit_conversion'];
    manufacturer = json['manufacturer'];
    trackSerialNo = json['track_serial_no'];
    trackBatchNo = json['track_batch_no'];
    itemStatus = json['item_status'];
    inventoryAccount = json['inventory_account'];
    salesAccount = json['sales_account'];
    salesReturnAccount = json['sales_return_account'];
    itemDiscountAccount = json['item_discount_account'];
    cogsAccount = json['cogs_account'];
    purchaseReturnAccount = json['purchase_return_account'];
    expenseAccount = json['expense_account'];
    unbilledGoodsAccount = json['unbilled_goods_account'];
    isConsignment = json['is_consignment'];
    isDiscontinue = json['is_discontinue'];
    displayStore = json['display_store'];
    displayDesc = json['display_desc'];
    tags = json['tags'];
    weight = json['weight'];
    volume = json['volume'];
    brand = json['brand'];
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
    data['barcode'] = this.barcode;
    data['item_sku'] = this.itemSku;
    data['item_sku_name'] = this.itemSkuName;
    data['vendor_item_code'] = this.vendorItemCode;
    data['vendor_item_name'] = this.vendorItemName;
    data['item_type'] = this.itemType;
    data['kategori_id'] = this.kategoriId;
    data['purchase_unit_id'] = this.purchaseUnitId;
    data['purchase_tax_id'] = this.purchaseTaxId;
    data['prefered_vendor_id'] = this.preferedVendorId;
    data['min_price'] = this.minPrice;
    data['is_fixed_price'] = this.isFixedPrice;
    data['item_picture'] = this.itemPicture;
    data['last_purchase_price'] = this.lastPurchasePrice;
    data['last_purchase_curr'] = this.lastPurchaseCurr;
    data['last_purchase_rate'] = this.lastPurchaseRate;
    data['profit_margin'] = this.profitMargin;
    data['minimum_stock'] = this.minimumStock;
    data['reorder_point'] = this.reorderPoint;
    data['maximum_stock'] = this.maximumStock;
    data['rack_location'] = this.rackLocation;
    data['warehouse_id'] = this.warehouseId;
    data['delivery_type'] = this.deliveryType;
    data['item_status_code_id'] = this.itemStatusCodeId;
    data['status_color'] = this.statusColor;
    data['discount_amount'] = this.discountAmount;
    data['create_by'] = this.createBy;
    data['add_date'] = this.addDate;
    data['update_date'] = this.updateDate;
    data['last_adjustment'] = this.lastAdjustment;
    data['size'] = this.size;
    data['color'] = this.color;
    data['size_unit'] = this.sizeUnit;
    data['unit_conversion'] = this.unitConversion;
    data['manufacturer'] = this.manufacturer;
    data['track_serial_no'] = this.trackSerialNo;
    data['track_batch_no'] = this.trackBatchNo;
    data['item_status'] = this.itemStatus;
    data['inventory_account'] = this.inventoryAccount;
    data['sales_account'] = this.salesAccount;
    data['sales_return_account'] = this.salesReturnAccount;
    data['item_discount_account'] = this.itemDiscountAccount;
    data['cogs_account'] = this.cogsAccount;
    data['purchase_return_account'] = this.purchaseReturnAccount;
    data['expense_account'] = this.expenseAccount;
    data['unbilled_goods_account'] = this.unbilledGoodsAccount;
    data['is_consignment'] = this.isConsignment;
    data['is_discontinue'] = this.isDiscontinue;
    data['display_store'] = this.displayStore;
    data['display_desc'] = this.displayDesc;
    data['tags'] = this.tags;
    data['weight'] = this.weight;
    data['volume'] = this.volume;
    data['brand'] = this.brand;
    return data;
  }
}
