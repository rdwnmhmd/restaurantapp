import 'dart:convert';
import '../model/restaurant_detail.dart';
import '../model/restaurant_list.dart';
import 'package:http/http.dart' as http;

import '../model/restaurant_search.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  // Service API untuk List Data
  Future<Restaurants> restaurant() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      return Restaurants.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  // Service API untuk Detail Data
  Future<Detail> restaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return Detail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  // Service API untuk Search Data
  Future<ResultRestaurantsSearch> searchingRestaurant(String query) async {
    // final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      return ResultRestaurantsSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Mendapatkan Hasil Pencarian');
    }
  }
}
