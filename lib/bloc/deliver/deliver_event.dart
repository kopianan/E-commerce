import 'package:meta/meta.dart';

@immutable
abstract class DeliverEvent {}

class GetAllPriceOfDeliver extends DeliverEvent {
  final int weight ;
  final int destination  ;
  final int origin;

  GetAllPriceOfDeliver(this.weight, this.destination, this.origin);


}