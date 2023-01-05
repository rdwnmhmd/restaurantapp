import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';

import '../api/api.dart';

enum ResultState { loading, noData, hasData, error, noConnection }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;
  DetailRestaurantProvider({required this.apiService, required this.id}) {
    _fetchAllRestaurant(id);
  }
  late Detail _detailRestaurant;
  late ResultState _state;
  String _message = '';
  String get message => _message;
  Detail get result => _detailRestaurant;
  ResultState get state => _state;
  Future<dynamic> _fetchAllRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.restaurantDetail(id);
      if (detailRestaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = detailRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
