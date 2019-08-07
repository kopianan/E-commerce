class DataBannerModel {
  String _bannerId;
  String _kategoriId;
  String _messages;
  String _picture;
  String _startDate;
  String _endDate;
  String _updateDate;
  String _lastUpdateBy;

  DataBannerModel(
      {String bannerId,
      String kategoriId,
      String messages,
      String picture,
      String startDate,
      String endDate,
      String updateDate,
      String lastUpdateBy}) {
    this._bannerId = bannerId;
    this._kategoriId = kategoriId;
    this._messages = messages;
    this._picture = picture;
    this._startDate = startDate;
    this._endDate = endDate;
    this._updateDate = updateDate;
    this._lastUpdateBy = lastUpdateBy;
  }

  String get bannerId => _bannerId;
  set bannerId(String bannerId) => _bannerId = bannerId;
  String get kategoriId => _kategoriId;
  set kategoriId(String kategoriId) => _kategoriId = kategoriId;
  String get messages => _messages;
  set messages(String messages) => _messages = messages;
  String get picture => _picture;
  set picture(String picture) => _picture = picture;
  String get startDate => _startDate;
  set startDate(String startDate) => _startDate = startDate;
  String get endDate => _endDate;
  set endDate(String endDate) => _endDate = endDate;
  String get updateDate => _updateDate;
  set updateDate(String updateDate) => _updateDate = updateDate;
  String get lastUpdateBy => _lastUpdateBy;
  set lastUpdateBy(String lastUpdateBy) => _lastUpdateBy = lastUpdateBy;

  DataBannerModel.fromJson(Map<String, dynamic> json) {
    _bannerId = json['banner_id'];
    _kategoriId = json['kategori_id'];
    _messages = json['messages'];
    _picture = json['picture'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _updateDate = json['update_date'];
    _lastUpdateBy = json['last_update_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_id'] = this._bannerId;
    data['kategori_id'] = this._kategoriId;
    data['messages'] = this._messages;
    data['picture'] = this._picture;
    data['start_date'] = this._startDate;
    data['end_date'] = this._endDate;
    data['update_date'] = this._updateDate;
    data['last_update_by'] = this._lastUpdateBy;
    return data;
  }
}
