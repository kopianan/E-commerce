class Point {
  String customerPointId;
  String customerId;
  double totalPoint;
  String lastUpdate;
  bool alreadyInSave;
  bool isNew;
  bool modified;

  Point(
      {this.customerPointId,
        this.customerId,
        this.totalPoint,
        this.lastUpdate,
        this.alreadyInSave,
        this.isNew,
        this.modified});

  Point.fromJson(Map<String, dynamic> json) {
    customerPointId = json['customerPointId'];
    customerId = json['customerId'];
    totalPoint = json['totalPoint'];
    lastUpdate = json['lastUpdate'];
    alreadyInSave = json['alreadyInSave'];
    isNew = json['isNew'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerPointId'] = this.customerPointId;
    data['customerId'] = this.customerId;
    data['totalPoint'] = this.totalPoint;
    data['lastUpdate'] = this.lastUpdate;
    data['alreadyInSave'] = this.alreadyInSave;
    data['isNew'] = this.isNew;
    data['modified'] = this.modified;
    return data;
  }
}
