import 'package:flutter/material.dart';
import 'package:tosik/data/api/api_service.dart';
import 'package:tosik/data/model/restaurant_list_model.dart';
import 'package:tosik/enum/result_state.dart';
import 'package:flutter/material.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    fetchAllRestaurant();
  }

  late RestaurantListResult _restaurantListResult;
  late ResultState _state;
  String _message = '';

  RestaurantListResult get result => _restaurantListResult;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurantList = await apiService.getRestaurantList();
      if (restaurantList.count == 0 && restaurantList.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantListResult = restaurantList;
      }
    } catch (x) {
      _state = ResultState.error;
      notifyListeners();

      return _message = 'Error $x';
    }
  }
}
