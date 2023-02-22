import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/api/api_service.dart';
import '../provider/restaurant_search_provider.dart';
import '../enum/result_state.dart';
import '../widgets/card_restaurant.dart';
import '../widgets/text_message.dart';
import '../widgets/loading.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/restaurant_search';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantSearchProvider(apiService: ApiService()),
      builder: (context, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Search'),
          ),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                    hintText: 'Search by name',
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  onSubmitted: (query) {
                    if (query != '') {
                      Provider.of<RestaurantSearchProvider>(
                        context,
                        listen: false,
                      ).fetchSearchRestaurant(query);
                    }
                  },
                ),
              ),
              Expanded(
                child: Consumer<RestaurantSearchProvider>(
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
                          itemCount: provider.result.restaurants.length,
                          itemBuilder: (_, index) {
                            final restaurant =
                                provider.result.restaurants[index];
                            return CardRestaurant(restaurant: restaurant);
                          },
                        );
                      case ResultState.noData:
                        return const TextMessage(
                          image: 'assets/lottie/96526-search-not-found.json',
                          message: 'Oopss... Pencarian tidak ditemukan',
                        );
                      case ResultState.error:
                        return const TextMessage(
                          image:
                              'assets/lottie/12955-no-internet-connection.json',
                          message: 'Koneksi Terputus',
                        );
                      default:
                        return const TextMessage(
                          image: 'assets/lottie/98877-search.json',
                          message: 'Silahkan lakukan pencarian...',
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
