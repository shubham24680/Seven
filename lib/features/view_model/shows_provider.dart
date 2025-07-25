import 'package:flutter/material.dart';
import 'package:seven/model/item.dart';
import 'package:seven/core/services/api.dart';

class ShowsProvider extends ChangeNotifier {
  final Api _api = Api();
  int _currentIndex = 0;
  List<Item> _shows = [];

  List<Item> get shows => _shows;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    _shows.clear();
    _shows = await _api.fetchShows("all");
    notifyListeners();
  }
}
