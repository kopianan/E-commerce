
import 'package:ecommerce_test/util/function.dart';
import 'package:flutter/cupertino.dart';

class PaymentMethod extends ChangeNotifier {

  int selectedPaymentMethod =-1 ;

  String arBalance = "";

  void setArBalanceString(String balance){
    this.arBalance = balance;
    notifyListeners();
  }
  ///Get String of ar balance format (5000)
  String getArBalanceString(){
    return Fun().formatStringCurrency(double.parse(arBalance).toStringAsFixed(0).toString());
  }
  ///Get ArBalance in double version for calculating the transaction purpose
  double getArBalanceDouble(){
    return double.parse(this.arBalance);
  }

  void setSelectedRadion(int val) {
    selectedPaymentMethod = val;
    notifyListeners();
  }


}