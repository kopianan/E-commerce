class DataItemModel {
  String itemId;
  String itemCode;
  String barcode;
  String updateDate;
  String kategoriId;
  String internalCode;
  String kategoriCode;
  String kategori;
  String katPicture;
  String itemName;
  String description;
  String itemPrice;
  String itmPriceFmt;
  String isFixedPrice;
  String qty;
  String unitCode;
  String taxCode;
  String pic;
  String displayStore;
  String weight;
  String inOrder;
  String boughQuantity;

  DataItemModel(
      {this.itemId,
        this.itemCode,
        this.barcode,
        this.updateDate,
        this.kategoriId,
        this.internalCode,
        this.kategoriCode,
        this.kategori,
        this.katPicture,
        this.itemName,
        this.description,
        this.itemPrice,
        this.itmPriceFmt,
        this.isFixedPrice,
        this.qty,
        this.unitCode,
        this.taxCode,
        this.pic,
        this.displayStore,
        this.weight,
        this.inOrder,
        this.boughQuantity});

  DataItemModel.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemCode = json['item_code'];
    barcode = json['barcode'];
    updateDate = json['update_date'];
    kategoriId = json['kategori_id'];
    internalCode = json['internal_code'];
    kategoriCode = json['kategori_code'];
    kategori = json['kategori'];
    katPicture = json['kat_picture'];
    itemName = json['item_name'];
    description = json['description'];
    itemPrice = json['item_price'];
    itmPriceFmt = json['itm_price_fmt'];
    isFixedPrice = json['is_fixed_price'];
    qty = json['qty'];
    unitCode = json['unit_code'];
    taxCode = json['tax_code'];
    pic = json['pic'];
    displayStore = json['display_store'];
    weight = json['weight'];
    inOrder = json['in_order'];
    boughQuantity = json['bough_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['item_code'] = this.itemCode;
    data['barcode'] = this.barcode;
    data['update_date'] = this.updateDate;
    data['kategori_id'] = this.kategoriId;
    data['internal_code'] = this.internalCode;
    data['kategori_code'] = this.kategoriCode;
    data['kategori'] = this.kategori;
    data['kat_picture'] = this.katPicture;
    data['item_name'] = this.itemName;
    data['description'] = this.description;
    data['item_price'] = this.itemPrice;
    data['itm_price_fmt'] = this.itmPriceFmt;
    data['is_fixed_price'] = this.isFixedPrice;
    data['qty'] = this.qty;
    data['unit_code'] = this.unitCode;
    data['tax_code'] = this.taxCode;
    data['pic'] = this.pic;
    data['display_store'] = this.displayStore;
    data['weight'] = this.weight;
    data['in_order'] = this.inOrder;
    data['bough_quantity'] = this.boughQuantity;
    return data;
  }
}
