import 'package:flutter/material.dart';
import 'package:netflix/model/item.dart';
import 'package:netflix/services/api.dart';

class ShowsProvider extends ChangeNotifier {
  final Api _api = Api();
  final List<Item> _shows = [];

  List<Item> get shows => _shows;

  Future<void> fetchCategories() async {
    _shows.clear();
    _shows.addAll(await _api.fetchShows());
    notifyListeners();
  }
}
