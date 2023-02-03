import 'package:flutter/widgets.dart';

import '../models/order_model.dart';

class OrdersProvider with ChangeNotifier {
  static final List<OrderModel> _orders = [];
  List<OrderModel> get getOrders {
    return _orders;
  }
}
