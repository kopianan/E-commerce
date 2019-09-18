
import 'package:ecommerce_test/models/AllTransactionListModel.dart';
import 'package:ecommerce_test/models/category_model.dart';
import 'package:ecommerce_test/models/data_item_model.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class CartListData extends ChangeNotifier {
  List<DataItemModel> cartListItem = List<DataItemModel>();
  AllTransactionListModel selectedTransactionDetail = AllTransactionListModel();
  List<List<CategoryModel>> listOfLIstCategory = List<List<CategoryModel>>() ;
  List<CategoryModel> historyCategoryModel  =List<CategoryModel>() ;


  final formatter = new NumberFormat("#,###");


  //Category LIST LIST
  void addCategoryList(List<CategoryModel> list){
    listOfLIstCategory.add(list);
    notifyListeners();
  }
  List<List<CategoryModel>> getCategoryList(){
    return listOfLIstCategory;
  }

  void clearCategoryListLastIndex(){
    listOfLIstCategory.removeLast();
    notifyListeners();
  }
  void clearCategoryListRange(int start, int end){
    listOfLIstCategory.removeRange(start, end);
    notifyListeners();
  }


  void addHistoryCategoryModel(CategoryModel history){
    historyCategoryModel.add( history);
    notifyListeners();
  }
  List<CategoryModel> getHistoryCategoryModel(){
    return historyCategoryModel;

  }

  void clearHistoryCategoryModelLastIndex(){
    historyCategoryModel.removeLast();
    notifyListeners();
  }
  void clearHistoryCategoryModelRange(int start, int end){
    historyCategoryModel.removeRange(start, end);
    notifyListeners();
  }


  void updateQuantity(int index, String newVal) {
    cartListItem[index].boughQuantity = newVal;

    notifyListeners();
  }

  void setSelectedTransactionDetail(AllTransactionListModel data ){
    selectedTransactionDetail = data ;
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
    return(int.parse(totalWeightSum.toStringAsFixed(0)) *1000);
  }

  String getTotalBayar(String subttotal, String pengiriman){
    if( subttotal == null || subttotal == "" || pengiriman == null || pengiriman == ""){
      return "0";
    }else {
      var total = int.parse(double.parse(subttotal).toStringAsFixed(0)) +
          int.parse(double.parse(pengiriman).toStringAsFixed(0));
      if (total == null) {
        return "0";
      } else
        return formatter.format(total).toString();
    }
  }


  String getSumOfPriceProduct(){
    var priceTotal = 0.0;

    cartListItem.forEach((obj){
      priceTotal = priceTotal + double.parse(obj.itemPrice) * double.parse(obj.boughQuantity);
    });
    return formatter.format(priceTotal.toInt());
  }

  void addItemListToList(DataItemModel data) {
    bool isDuplicate = false ;

    cartListItem.forEach((f) {
      if(f.itemId == data.itemId){
        var qtyCheck = double.parse(f.boughQuantity.toString()).toStringAsFixed(0);
        data.boughQuantity = (int.parse(qtyCheck) + 1).toString();
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
