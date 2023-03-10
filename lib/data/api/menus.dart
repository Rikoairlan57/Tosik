import 'package:tosik/data/api/category.dart';
import 'package:tosik/data/api/foods.dart';

class Menus {
  Menus({required this.foods, required this.drinks});

  List<Foods> foods;
  List<Category> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Foods>.from(json["foods"].map((x) => Foods.fromJson(x))),
        drinks: List<Category>.from(
          json["drinks"].map((x) => Category.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}
