class DataItemModel {
  String _sId;
  String _kategoriId;
  String _internalCode;
  String _kategoriCode;
  String _kategori;
  String _katPicture;
  String _itemId;
  String _itemCode;
  String _barcode;
  String _itemName;
  String _description;
  String _itemPrice;
  String _itmPriceFmt;
  String _isFixedPrice;
  String _qty;
  String _unitCode;
  String _taxCode;
  String _code;
  String _pic;
  String _displayStore;
  String _weight;
  String _inOrder;

  DataItemModelModel(
      {String sId,
      String kategoriId,
      String internalCode,
      String kategoriCode,
      String kategori,
      String katPicture,
      String itemId,
      String itemCode,
      String barcode,
      String itemName,
      String description,
      String itemPrice,
      String itmPriceFmt,
      String isFixedPrice,
      String qty,
      String unitCode,
      String taxCode,
      String code,
      String pic,
      String displayStore,
      String weight,
      String inOrder}) {
    this._sId = sId;
    this._kategoriId = kategoriId;
    this._internalCode = internalCode;
    this._kategoriCode = kategoriCode;
    this._kategori = kategori;
    this._katPicture = katPicture;
    this._itemId = itemId;
    this._itemCode = itemCode;
    this._barcode = barcode;
    this._itemName = itemName;
    this._description = description;
    this._itemPrice = itemPrice;
    this._itmPriceFmt = itmPriceFmt;
    this._isFixedPrice = isFixedPrice;
    this._qty = qty;
    this._unitCode = unitCode;
    this._taxCode = taxCode;
    this._code = code;
    this._pic = pic;
    this._displayStore = displayStore;
    this._weight = weight;
    this._inOrder = inOrder;
  }

  String get sId => _sId;
  set sId(String sId) => _sId = sId;
  String get kategoriId => _kategoriId;
  set kategoriId(String kategoriId) => _kategoriId = kategoriId;
  String get internalCode => _internalCode;
  set internalCode(String internalCode) => _internalCode = internalCode;
  String get kategoriCode => _kategoriCode;
  set kategoriCode(String kategoriCode) => _kategoriCode = kategoriCode;
  String get kategori => _kategori;
  set kategori(String kategori) => _kategori = kategori;
  String get katPicture => _katPicture;
  set katPicture(String katPicture) => _katPicture = katPicture;
  String get itemId => _itemId;
  set itemId(String itemId) => _itemId = itemId;
  String get itemCode => _itemCode;
  set itemCode(String itemCode) => _itemCode = itemCode;
  String get barcode => _barcode;
  set barcode(String barcode) => _barcode = barcode;
  String get itemName => _itemName;
  set itemName(String itemName) => _itemName = itemName;
  String get description => _description;
  set description(String description) => _description = description;
  String get itemPrice => _itemPrice;
  set itemPrice(String itemPrice) => _itemPrice = itemPrice;
  String get itmPriceFmt => _itmPriceFmt;
  set itmPriceFmt(String itmPriceFmt) => _itmPriceFmt = itmPriceFmt;
  String get isFixedPrice => _isFixedPrice;
  set isFixedPrice(String isFixedPrice) => _isFixedPrice = isFixedPrice;
  String get qty => _qty;
  set qty(String qty) => _qty = qty;
  String get unitCode => _unitCode;
  set unitCode(String unitCode) => _unitCode = unitCode;
  String get taxCode => _taxCode;
  set taxCode(String taxCode) => _taxCode = taxCode;
  String get code => _code;
  set code(String code) => _code = code;
  String get pic => _pic;
  set pic(String pic) => _pic = pic;
  String get displayStore => _displayStore;
  set displayStore(String displayStore) => _displayStore = displayStore;
  String get weight => _weight;
  set weight(String weight) => _weight = weight;
  String get inOrder => _inOrder;
  set inOrder(String inOrder) => _inOrder = inOrder;

  DataItemModel.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _kategoriId = json['kategori_id'];
    _internalCode = json['internal_code'];
    _kategoriCode = json['kategori_code'];
    _kategori = json['kategori'];
    _katPicture = json['kat_picture'];
    _itemId = json['item_id'];
    _itemCode = json['item_code'];
    _barcode = json['barcode'];
    _itemName = json['item_name'];
    _description = json['description'];
    _itemPrice = json['item_price'];
    _itmPriceFmt = json['itm_price_fmt'];
    _isFixedPrice = json['is_fixed_price'];
    _qty = json['qty'];
    _unitCode = json['unit_code'];
    _taxCode = json['tax_code'];
    _code = json['code'];
    _pic = json['pic'];
    _displayStore = json['display_store'];
    _weight = json['weight'];
    _inOrder = json['in_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['kategori_id'] = this._kategoriId;
    data['internal_code'] = this._internalCode;
    data['kategori_code'] = this._kategoriCode;
    data['kategori'] = this._kategori;
    data['kat_picture'] = this._katPicture;
    data['item_id'] = this._itemId;
    data['item_code'] = this._itemCode;
    data['barcode'] = this._barcode;
    data['item_name'] = this._itemName;
    data['description'] = this._description;
    data['item_price'] = this._itemPrice;
    data['itm_price_fmt'] = this._itmPriceFmt;
    data['is_fixed_price'] = this._isFixedPrice;
    data['qty'] = this._qty;
    data['unit_code'] = this._unitCode;
    data['tax_code'] = this._taxCode;
    data['code'] = this._code;
    data['pic'] = this._pic;
    data['display_store'] = this._displayStore;
    data['weight'] = this._weight;
    data['in_order'] = this._inOrder;
    return data;
  }
}