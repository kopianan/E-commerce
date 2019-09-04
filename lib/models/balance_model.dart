class BalanceModel {
  String arBalance;

  BalanceModel({this.arBalance});

  BalanceModel.fromJson(Map<String, dynamic> json) {
    arBalance = json['ar_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ar_balance'] = this.arBalance;
    return data;
  }
}
