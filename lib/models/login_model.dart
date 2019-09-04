class LoginModel {
  String _userId;
  String _parentId;
  String _userName;
  String _email;
  String _phone;
  String _password;
  String _fullName;
  String _typeIds;
  int _status;
  String _birthDate;
  String _address;
  String _shipTo1;
  String _shipTo2;
  String _country;
  String _province;
  String _city;
  String _district;
  String _village;
  String _terrId1;
  String _terrId2;
  String _terrId3;
  String _terrId4;
  double _longitudes;
  double _latitudes;
  String _regDate;
  String _fbToken;
  String _googleToken;
  String _msgToken;
  String _otherToken;
  bool _alreadyInSave;
  bool _isNew;
  bool _modified;
  int error = 0 ;
  LoginModel(
      {String userId,
      String parentId,
      String userName,
      String email,
      String phone,
      String password,
      String fullName,
      String typeIds,
      int status,
      String birthDate,
      String address,
      String shipTo1,
      String shipTo2,
      String country,
      String province,
      String city,
      String district,
      String village,
      String terrId1,
      String terrId2,
      String terrId3,
      String terrId4,
      double longitudes,
      double latitudes,
      String regDate,
      String fbToken,
      String googleToken,
      String msgToken,
      String otherToken,
      bool alreadyInSave,
      bool isNew,
      bool modified,
      int error}) {
    this._userId = userId;
    this._parentId = parentId;
    this._userName = userName;
    this._email = email;
    this._phone = phone;
    this._password = password;
    this._fullName = fullName;
    this._typeIds = typeIds;
    this._status = status;
    this._birthDate = birthDate;
    this._address = address;
    this._shipTo1 = shipTo1;
    this._shipTo2 = shipTo2;
    this._country = country;
    this._province = province;
    this._city = city;
    this._district = district;
    this._village = village;
    this._terrId1 = terrId1;
    this._terrId2 = terrId2;
    this._terrId3 = terrId3;
    this._terrId4 = terrId4;
    this._longitudes = longitudes;
    this._latitudes = latitudes;
    this._regDate = regDate;
    this._fbToken = fbToken;
    this._googleToken = googleToken;
    this._msgToken = msgToken;
    this._otherToken = otherToken;
    this._alreadyInSave = alreadyInSave;
    this._isNew = isNew;
    this._modified = modified;
    this.error = error;
  }

  String get userId => _userId;
  set userId(String userId) => _userId = userId;
  String get parentId => _parentId;
  set parentId(String parentId) => _parentId = parentId;
  String get userName => _userName;
  set userName(String userName) => _userName = userName;
  String get email => _email;
  set email(String email) => _email = email;
  String get phone => _phone;
  set phone(String phone) => _phone = phone;
  String get password => _password;
  set password(String password) => _password = password;
  String get fullName => _fullName;
  set fullName(String fullName) => _fullName = fullName;
  String get typeIds => _typeIds;
  set typeIds(String typeIds) => _typeIds = typeIds;
  int get status => _status;
  set status(int status) => _status = status;
  String get birthDate => _birthDate;
  set birthDate(String birthDate) => _birthDate = birthDate;
  String get address => _address;
  set address(String address) => _address = address;
  String get shipTo1 => _shipTo1;
  set shipTo1(String shipTo1) => _shipTo1 = shipTo1;
  String get shipTo2 => _shipTo2;
  set shipTo2(String shipTo2) => _shipTo2 = shipTo2;
  String get country => _country;
  set country(String country) => _country = country;
  String get province => _province;
  set province(String province) => _province = province;
  String get city => _city;
  set city(String city) => _city = city;
  String get district => _district;
  set district(String district) => _district = district;
  String get village => _village;
  set village(String village) => _village = village;
  String get terrId1 => _terrId1;
  set terrId1(String terrId1) => _terrId1 = terrId1;
  String get terrId2 => _terrId2;
  set terrId2(String terrId2) => _terrId2 = terrId2;
  String get terrId3 => _terrId3;
  set terrId3(String terrId3) => _terrId3 = terrId3;
  String get terrId4 => _terrId4;
  set terrId4(String terrId4) => _terrId4 = terrId4;
  double get longitudes => _longitudes;
  set longitudes(double longitudes) => _longitudes = longitudes;
  double get latitudes => _latitudes;
  set latitudes(double latitudes) => _latitudes = latitudes;
  String get regDate => _regDate;
  set regDate(String regDate) => _regDate = regDate;
  String get fbToken => _fbToken;
  set fbToken(String fbToken) => _fbToken = fbToken;
  String get googleToken => _googleToken;
  set googleToken(String googleToken) => _googleToken = googleToken;
  String get msgToken => _msgToken;
  set msgToken(String msgToken) => _msgToken = msgToken;
  String get otherToken => _otherToken;
  set otherToken(String otherToken) => _otherToken = otherToken;
  bool get alreadyInSave => _alreadyInSave;
  set alreadyInSave(bool alreadyInSave) => _alreadyInSave = alreadyInSave;
  bool get isNew => _isNew;
  set isNew(bool isNew) => _isNew = isNew;
  bool get modified => _modified;
  set modified(bool modified) => _modified = modified;

  LoginModel.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _parentId = json['parentId'];
    _userName = json['userName'];
    _email = json['email'];
    _phone = json['phone'];
    _password = json['password'];
    _fullName = json['fullName'];
    _typeIds = json['typeIds'];
    _status = json['status'];
    _birthDate = json['birthDate'];
    _address = json['address'];
    _shipTo1 = json['shipTo1'];
    _shipTo2 = json['shipTo2'];
    _country = json['country'];
    _province = json['province'];
    _city = json['city'];
    _district = json['district'];
    _village = json['village'];
    _terrId1 = json['terrId1'];
    _terrId2 = json['terrId2'];
    _terrId3 = json['terrId3'];
    _terrId4 = json['terrId4'];
    _longitudes = json['longitudes'];
    _latitudes = json['latitudes'];
    _regDate = json['regDate'];
    _fbToken = json['fbToken'];
    _googleToken = json['googleToken'];
    _msgToken = json['msgToken'];
    _otherToken = json['otherToken'];
    _alreadyInSave = json['alreadyInSave'];
    _isNew = json['isNew'];
    _modified = json['modified'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this._userId;
    data['parentId'] = this._parentId;
    data['userName'] = this._userName;
    data['email'] = this._email;
    data['phone'] = this._phone;
    data['password'] = this._password;
    data['fullName'] = this._fullName;
    data['typeIds'] = this._typeIds;
    data['status'] = this._status;
    data['birthDate'] = this._birthDate;
    data['address'] = this._address;
    data['shipTo1'] = this._shipTo1;
    data['shipTo2'] = this._shipTo2;
    data['country'] = this._country;
    data['province'] = this._province;
    data['city'] = this._city;
    data['district'] = this._district;
    data['village'] = this._village;
    data['terrId1'] = this._terrId1;
    data['terrId2'] = this._terrId2;
    data['terrId3'] = this._terrId3;
    data['terrId4'] = this._terrId4;
    data['longitudes'] = this._longitudes;
    data['latitudes'] = this._latitudes;
    data['regDate'] = this._regDate;
    data['fbToken'] = this._fbToken;
    data['googleToken'] = this._googleToken;
    data['msgToken'] = this._msgToken;
    data['otherToken'] = this._otherToken;
    data['alreadyInSave'] = this._alreadyInSave;
    data['isNew'] = this._isNew;
    data['modified'] = this._modified;
    data['error'] = this.error;
    return data;
  }
}
