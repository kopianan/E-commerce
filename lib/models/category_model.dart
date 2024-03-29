class CategoryModel {
  String _kategoriId;
  String _parentId;
  String _internalCode;
  String _kategoriCode;
  String _description;
  String _picture;
  String _displayStore;

  CategoryModel(
      {String kategoriId,
      String parentId,
      String internalCode,
      String kategoriCode,
      String description,
      String picture,
      String displayStore}) {
    this._kategoriId = kategoriId;
    this._parentId = parentId;
    this._internalCode = internalCode;
    this._kategoriCode = kategoriCode;
    this._description = description;
    this._picture = picture;
    this._displayStore = displayStore;
  }

  String get kategoriId => _kategoriId;
  set kategoriId(String kategoriId) => _kategoriId = kategoriId;
  String get parentId => _parentId;
  set parentId(String parentId) => _parentId = parentId;
  String get internalCode => _internalCode;
  set internalCode(String internalCode) => _internalCode = internalCode;
  String get kategoriCode => _kategoriCode;
  set kategoriCode(String kategoriCode) => _kategoriCode = kategoriCode;
  String get description => _description;
  set description(String description) => _description = description;
  String get picture => _picture;
  set picture(String picture) => _picture = picture;
  String get displayStore => _displayStore;
  set displayStore(String displayStore) => _displayStore = displayStore;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    _kategoriId = json['kategori_id'];
    _parentId = json['parent_id'];
    _internalCode = json['internal_code'];
    _kategoriCode = json['kategori_code'];
    _description = json['description'];
    _picture = json['picture'];
    _displayStore = json['display_store'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kategori_id'] = this._kategoriId;
    data['parent_id'] = this._parentId;
    data['internal_code'] = this._internalCode;
    data['kategori_code'] = this._kategoriCode;
    data['description'] = this._description;
    data['picture'] = this._picture;
    data['display_store'] = this._displayStore;
    return data;
  }
}
