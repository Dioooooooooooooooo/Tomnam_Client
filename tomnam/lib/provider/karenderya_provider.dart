import 'package:flutter/foundation.dart';
import 'package:tomnam/models/karenderya.dart';

class KarenderyaProvider with ChangeNotifier {
  List<Karenderya> _stores = [];

  List<Karenderya> get stores => _stores;

  void setStores(List<Karenderya> stores) {
    _stores = stores;
    notifyListeners();
  }
}