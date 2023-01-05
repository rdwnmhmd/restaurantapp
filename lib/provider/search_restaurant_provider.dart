import 'package:flutter/foundation.dart';
import 'package:restaurant_app/api/api.dart';

import '../model/restaurant_search.dart';

enum StateResultSearch { loading, noData, hasData, error }

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService serviceAPISearch;

  SearchRestaurantProvider({required this.serviceAPISearch}) {
    fetchAllRestaurantSearch(query);
  }

  ResultRestaurantsSearch? _resultRestaurantsSearch;
  String _message = '';
  String _query = '';
  StateResultSearch? _state;

  String get message => _message;
  String get query => _query;

  ResultRestaurantsSearch? get result => _resultRestaurantsSearch;

  StateResultSearch? get state => _state;

  Future<dynamic> fetchAllRestaurantSearch(String query) async {
    try {
      _state = StateResultSearch.loading;
      _query = query;

      final restaurantSearch =
          await serviceAPISearch.searchingRestaurant(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = StateResultSearch.noData;
        notifyListeners();
        return _message = 'Data Tidak Ditemukan :(';
      } else {
        _state = StateResultSearch.hasData;

        notifyListeners();
        return _resultRestaurantsSearch = restaurantSearch;
      }
    } catch (error) {
      _state = StateResultSearch.error;
      notifyListeners();
      return _message = 'Sepertinya Ada Masalah :(';
    }
  }
}
