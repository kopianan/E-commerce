import 'package:ecommerce_test/models/bought_item_model.dart';
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:flutter/foundation.dart';

class CartListData extends ChangeNotifier {
  List<BoughItem> listItem = List<BoughItem>();
  List<DataItemModel> cartListItem = List<DataItemModel>();

  void initialAllTransaction(List<BoughItem> list) {
    listItem = list;
    notifyListeners();
  }

  void addItemToCart(BoughItem item) {
    listItem.add(item);
    notifyListeners();
  }

  void addItemListToList(DataItemModel data) {
    cartListItem.add(data);
    notifyListeners();
  }

  List<BoughItem> getListCart() {
    print(listItem.toString());
    return listItem;
  }

  String getItemListLength() {
    return cartListItem.length.toString();
  }
}
