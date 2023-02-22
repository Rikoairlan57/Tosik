// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tosik/data/model/restaurant_detail_model.dart';
import 'package:tosik/data/model/restaurant_list_model.dart';
import 'package:tosik/data/model/review_model.dart';
import 'package:tosik/data/model/restaurant_search_model.dart';

class ApiService {
  static const String _baseurl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantListResult> getRestaurantList() async {
    final response = await http.get(
      Uri.parse("$_baseurl/list"),
    );
    if (response.statusCode == 200) {
      return RestaurantListResult.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception("Failed Load Data");
    }
  }

  Future<RestaurantDetailResult> getRestaurantDetail(String id) async {
    final response = await http.get(
      Uri.parse('$_baseurl/detail/$id'),
    );
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception("Failed Load Data");
    }
  }

  Future<RestaurantSearchResult> getRestaurantSearch(String query) async {
    final response = await http.get(
      Uri.parse("$_baseurl/search?q=$query"),
    );
    if (response.statusCode == 200) {
      return RestaurantSearchResult.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception("Failed Load Data");
    }
  }

  Future<ReviewResult> postReview({
    required String id,
    required String name,
    required String review,
  }) async {
    final response = await http.post(
      Uri.parse("$_baseurl/review"),
      body: jsonEncode(
        <String, String>{
          'id': id,
          "name": name,
          "review": review,
        },
      ),
      headers: <String, String>{
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == 201) {
      return ReviewResult.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception("Failed Post Review");
    }
  }
}
