import 'package:flutter/widgets.dart';

import '../models/viewed_model.dart';

class ViewedProvider with ChangeNotifier {
  Map<String, ViewedModel> _viewedItem = {};

  Map<String, ViewedModel> get getViewedItem {
    return _viewedItem;
  }

  void addProductToHistory({required String productId}) {
    _viewedItem.putIfAbsent(
      productId,
      () => ViewedModel(
        id: DateTime.now().toString(),
        productId: productId,
      ),
    );
    notifyListeners();
  }

  void clearHistory() {
    _viewedItem.clear();
    notifyListeners();
  }
}
