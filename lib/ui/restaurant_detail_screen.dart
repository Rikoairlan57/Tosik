// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:tosik/data/api/api_service.dart';
import 'package:tosik/data/model/restaurant_list_model.dart';
import 'package:tosik/enum/result_state.dart';
import 'package:tosik/provider/restaurant_detail_provider.dart';
import 'package:tosik/widgets/loading.dart';
import 'package:tosik/widgets/restaurant_detail_content.dart';
import 'package:tosik/widgets/text_message.dart';

class RestaurantDetailScreen extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final RestaurantModel restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
        apiService: ApiService(http.Client()),
        restaurantId: restaurant.id,
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<RestaurantDetailProvider>(
          builder: (_, provider, __) {
            switch (provider.state) {
              case ResultState.loading:
                return const Loading();
              case ResultState.hasData:
                return ContentRestaurant(
                  provider: provider,
                  restaurant: provider.result.restaurant,
                );
              case ResultState.error:
                return TextMessage(
                  lottie: 'assets/lottie/12955-no-internet-connection.json',
                  message: 'Koneksi Terputus',
                  onPressed: () =>
                      provider.fetchDetailRestaurant(restaurant.id),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
      floatingActionButton: _backButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget _backButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      )
          .animate()
          .fade(
            duration: 850.ms,
          )
          .slideY(
            begin: -0.3,
            duration: 1200.ms,
            curve: Curves.fastOutSlowIn,
          ),
    )
        .animate()
        .fade(
          duration: 750.ms,
        )
        .slideY(
          begin: -0.3,
          duration: 600.ms,
          curve: Curves.fastOutSlowIn,
        );
  }
}
