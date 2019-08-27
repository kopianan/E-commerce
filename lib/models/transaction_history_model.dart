class TransactionHistoryModel {
  String _transactionNo;
  String _transactionDate;
  String _transactionType;
  String _remark;
  String _amount;

  TransactionHistoryModel(
      {String transactionNo,
        String transactionDate,
        String transactionType,
        String remark,
        String amount}) {
    this._transactionNo = transactionNo;
    this._transactionDate = transactionDate;
    this._transactionType = transactionType;
    this._remark = remark;
    this._amount = amount;
  }

  String get transactionNo => _transactionNo;
  set transactionNo(String transactionNo) => _transactionNo = transactionNo;
  String get transactionDate => _transactionDate;
  set transactionDate(String transactionDate) =>
      _transactionDate = transactionDate;
  String get transactionType => _transactionType;
  set transactionType(String transactionType) =>
      _transactionType = transactionType;
  String get remark => _remark;
  set remark(String remark) => _remark = remark;
  String get amount => _amount;
  set amount(String amount) => _amount = amount;

  TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    _transactionNo = json['transaction_no'];
    _transactionDate = json['transaction_date'];
    _transactionType = json['transaction_type'];
    _remark = json['remark'];
    _amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_no'] = this._transactionNo;
    data['transaction_date'] = this._transactionDate;
    data['transaction_type'] = this._transactionType;
    data['remark'] = this._remark;
    data['amount'] = this._amount;
    return data;
  }
}
