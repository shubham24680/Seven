import 'package:flutter/material.dart';
import 'package:netflix/model/item.dart';
import 'package:netflix/services/api.dart';

class ShowsProvider extends ChangeNotifier {
  final Api _api = Api();
  int _currentIndex = 0;
  final List<Item> _shows = [];

  List<Item> get shows => _shows;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    _shows.clear();
    _shows.addAll(await _api.fetchShows());
    notifyListeners();
  }
}
