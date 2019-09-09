
import 'package:intl/intl.dart';

class Fun{
  var format = NumberFormat("#,###") ;
  String formatStringCurrency(String input){

    var data = double.parse(input).toStringAsFixed(0);
    return format.format(int.parse(data)).toString() ;


  }

}