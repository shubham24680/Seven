import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:seven/model/item.dart';
import 'package:seven/core/services/api.dart';

class SearchProvider extends ChangeNotifier {
  final Api _api = Api();
  final List<Item> _searchedShows = [];
  TextEditingController searchController = TextEditingController();

  List<Item> get searchedShows => _searchedShows;

  Future<void> search(String keyword) async {
    log(keyword);
    _searchedShows.clear();
    if (keyword.isEmpty) {
      _searchedShows.clear();
    } else {
      _searchedShows.addAll(await _api.fetchShows(keyword.trim()));
    }
    notifyListeners();
  }
}
