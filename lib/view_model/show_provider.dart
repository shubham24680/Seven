import 'package:flutter/material.dart';
import 'package:netflix/model/item.dart';
import 'package:netflix/services/api.dart';

class ShowProvider extends ChangeNotifier {
  final Api _api = Api();
  final List<Item> _drama = [];
  final List<Item> _sports = [];
  final List<Item> _thriller = [];

  List<Item> get drama => _drama;
  List<Item> get sports => _sports;
  List<Item> get thriller => _thriller;

  Future<void> fetchCategories() async {
    _drama.clear();
    _sports.clear();
    _thriller.clear();

    _drama.addAll(await _api.fetchShows('drama'));
    _sports.addAll(await _api.fetchShows('sports'));
    _thriller.addAll(await _api.fetchShows('thriller'));

    notifyListeners();
  }
}
