import 'package:tosik/data/model/restaurant_list_model.dart';

class RestaurantSearchResult {
  RestaurantSearchResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<RestaurantModel> restaurants;

  factory RestaurantSearchResult.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResult(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantModel>.from(
          json["restaurants"].map(
            (x) => RestaurantModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(
          restaurants.map(
            (x) => x.toJson(),
          ),
        )
      };
}
