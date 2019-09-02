
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:flutter/foundation.dart';

class CartListData extends ChangeNotifier {
  List<DataItemModel> cartListItem = List<DataItemModel>();

  void updateQuantity(int index, String newVal) {
    cartListItem[index].boughQuantity = newVal;

    notifyListeners();
  }

  int getAllItemWeight() {
    var totalWeightSum = 0.0;

    cartListItem.forEach((obj) {
      if (obj.weight == "")
        totalWeightSum = totalWeightSum + (1 * double.parse(obj.boughQuantity));
      else
        totalWeightSum = totalWeightSum +
            (double.parse(obj.weight) * double.parse(obj.boughQuantity));
    });
    return (int.parse(totalWeightSum.toStringAsFixed(0)));
  }

  void addItemListToList(DataItemModel data) {
    bool isDuplicate = false ;

    cartListItem.forEach((f) {
      if(f.itemId == data.itemId){
        data.boughQuantity = (int.parse(f.boughQuantity) + 1).toString();
        isDuplicate = true;
      }
    });
    if(isDuplicate == false) {
      cartListItem.add(data);
      isDuplicate = false ;
    }
    notifyListeners();
  }

  String getSubTotal() {
    double subTotal = 0.0;
    cartListItem.forEach((it) {
      subTotal = subTotal +
          (double.parse(it.itemPrice) * double.parse(it.boughQuantity));
    });
    return subTotal.toString();
  }

  String getItemListLength() {
    return cartListItem.length.toString();
  }

  void clearItemOfList(DataItemModel data) {
    cartListItem.remove(data);
    notifyListeners();
  }
}
