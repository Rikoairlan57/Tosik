// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tosik/data/api/api_service.dart';
import 'package:tosik/enum/result_state.dart';
import 'package:tosik/provider/restaurant_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:tosik/ui/search_screen.dart';
import 'package:tosik/widgets/loading.dart';
import 'package:tosik/widgets/card_restaurant.dart';
import 'package:tosik/widgets/text_message.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});
  static const routeName = '/restaurant_screen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantListProvider>(
      create: (_) => RestaurantListProvider(
        apiService: ApiService(),
      ),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildList(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Center(
        child: Text(
          "Tongkrongan Asik",
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SearchScreen.routeName);
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantListProvider>(
      builder: (_, provider, __) {
        switch (provider.state) {
          case ResultState.loading:
            return const Loading();
          case ResultState.hasData:
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              itemCount: provider.result.count,
              itemBuilder: (_, index) {
                final restaurant = provider.result.restaurants[index];
                return CardRestaurant(restaurant: restaurant);
              },
            );
          case ResultState.noData:
            return const TextMessage(
              image: 'assets/lottie/85023-no-data.json',
              message: 'Data Kosong',
            );
          case ResultState.error:
            return TextMessage(
              image: 'assets/lottie/12955-no-internet-connection.json',
              message: 'Koneksi Terputus',
              onPressed: () => provider.fetchAllRestaurant(),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
