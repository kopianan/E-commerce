
import 'package:flutter/cupertino.dart';

class PaymentMethod extends ChangeNotifier {

  int selectedPaymentMethod =-1 ;

  void setSelectedRadion(int val) {
    selectedPaymentMethod = val;
    notifyListeners();
  }


}