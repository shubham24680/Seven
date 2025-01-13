import 'package:flutter/material.dart';
import 'package:netflix/view/search/search.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/search': (_) => Search(),
};
