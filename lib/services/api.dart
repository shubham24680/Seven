import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix/model/item.dart';

class Api {
  // Use the X-RapidAPI-Host to form the base URL
  static const String baseUrl = "https://api.tvmaze.com";

  // fetch the products from Rapid
  Future<List<Item>> fetchShows() async {
    final url = Uri.parse('$baseUrl/search/shows?q=all');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData
            .map<Item>((json) => Item.fromJson(json))
            .toList(); // Return in form of list.
      } else {
        throw Exception("Failed to fetch products: ${response.statusCode}");
      }
    } catch (error) {
      rethrow;
    }
  }
}
