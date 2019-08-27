
import 'package:ecommerce_test/models/bought_item_model.dart';
import 'package:flutter/foundation.dart';

class CartListData extends ChangeNotifier {
  List<BoughItem> listItem = List<BoughItem>();

  void initialAllTransaction(List<BoughItem> list) {
    listItem = list;
    notifyListeners();
  }

  void addItemToCart(BoughItem item){
    listItem.add(item);
    notifyListeners();
  }

  List<BoughItem> getListCart() {
    print(listItem.toString());
    return listItem;
  }
}
