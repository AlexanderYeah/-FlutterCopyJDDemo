import 'package:event_bus/event_bus.dart';

EventBus eventStatus = EventBus();

class ProductDetailEvent {
  String _str = "";
  ProductDetailEvent(String str) {
    this._str = str;
  }
}
