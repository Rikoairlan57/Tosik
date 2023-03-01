import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tosik/data/model/review_model.dart';
import 'package:tosik/data/model/restaurant_detail_model.dart';
import 'package:tosik/data/model/restaurant_list_model.dart';
import 'package:tosik/data/model/restaurant_search_model.dart';

class ApiService {
  final http.Client client;

  ApiService(this.client);

  static const String baseurl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantListResult> getRestaurantList() async {
    final response = await client.get(
      Uri.parse('$baseurl/list'),
    );
    if (response.statusCode == 200) {
      return RestaurantListResult.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RestaurantDetailResult> getRestaurantDetail(String id) async {
    final response = await client.get(
      Uri.parse('$baseurl/detail/$id'),
    );
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RestaurantSearchResult> getRestaurantSearch(String query) async {
    final response = await client.get(
      Uri.parse('$baseurl/search?q=$query'),
    );
    if (response.statusCode == 200) {
      return RestaurantSearchResult.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ReviewResult> postReview({
    required String id,
    required String name,
    required String review,
  }) async {
    final response = await client.post(
      Uri.parse('$baseurl/review'),
      body: jsonEncode(<String, String>{
        'id': id,
        'name': name,
        'review': review,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      return ReviewResult.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed post data');
    }
  }
}
