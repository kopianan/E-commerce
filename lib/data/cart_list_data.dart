import 'package:ecommerce_test/models/bought_item_model.dart';
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:flutter/foundation.dart';

class CartListData extends ChangeNotifier {
  List<DataItemModel> cartListItem = List<DataItemModel>();



  void updateQuantity(int index, String newVal){
    cartListItem[index].boughQuantity = newVal;
    notifyListeners();
  }


  void addItemListToList(DataItemModel data) {
    cartListItem.add(data);
    notifyListeners();
  }

  String getSubTotal(){
    cartListItem.length.toString() ;
  }


  String getItemListLength() {
    return cartListItem.length.toString();
  }

  void clearItemOfList(DataItemModel data) {
    cartListItem.remove(data);
    notifyListeners();
  }
}
