import 'package:flutter/material.dart';
import '../model/restaurant_list.dart';
import '../api/api.dart';

enum ListResultState { loading, noData, hasData, error }

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchAllRestaurantList();
  }

  late Restaurants _restaurantResult;
  late ListResultState _state;
  String _message = '';

  Restaurants get restaurantResult => _restaurantResult;
  ListResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchAllRestaurantList() async {
    try {
      _state = ListResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ListResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ListResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ListResultState.error;
      notifyListeners();
      return _message = "Error ----> $e";
    }
  }
}
