import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tosik/common/styles.dart';
import 'package:tosik/provider/database_provider.dart';
import 'package:tosik/provider/restaurant_detail_provider.dart';
import 'package:tosik/data/model/restaurant_detail_model.dart';
import 'package:tosik/widgets/review_customer.dart';
import 'package:tosik/widgets/card_menu.dart';
import 'package:tosik/data/model/restaurant_list_model.dart';

class ContentRestaurant extends StatelessWidget {
  final RestaurantDetailModel restaurant;
  final RestaurantDetailProvider provider;

  const ContentRestaurant({
    super.key,
    required this.restaurant,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final heightImage = MediaQuery.of(context).size.height * 0.4;
    final widthImage = MediaQuery.of(context).size.width;

    return Consumer<DatabaseProvider>(
      builder: (_, providerFavorite, __) {
        return FutureBuilder(
          future: providerFavorite.isFavorited(restaurant.id),
          builder: (_, snapshot) {
            final isFavorited = snapshot.data ?? false;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: heightImage,
                    width: widthImage,
                    child: Stack(
                      children: [
                        Hero(
                          tag: restaurant.pictureId,
                          child: Container(
                            height: heightImage,
                            width: widthImage,
                            margin: const EdgeInsets.only(
                                left: 12, right: 12, top: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: widthImage - (widthImage - 28),
                          bottom: heightImage - (heightImage - 16),
                          child: isFavorited
                              ? FloatingActionButton(
                                  onPressed: () {
                                    providerFavorite
                                        .removeFavorite(restaurant.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                          'Dihapuskan dari favorit',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.favorite,
                                    size: 28,
                                  ),
                                )
                              : FloatingActionButton(
                                  onPressed: () {
                                    providerFavorite.addFavorite(
                                      RestaurantModel(
                                        id: restaurant.id,
                                        name: restaurant.name,
                                        description: restaurant.description,
                                        city: restaurant.city,
                                        pictureId: restaurant.pictureId,
                                        rating: restaurant.rating,
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                          'Ditambahkan ke favorit',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.favorite_border,
                                    size: 28,
                                  ),
                                ),
                        )
                            .animate()
                            .fade(
                              duration: 850.ms,
                            )
                            .slideX(
                              begin: 0.3,
                              duration: 1200.ms,
                              curve: Curves.fastOutSlowIn,
                            ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurant.name,
                                    style:
                                        Theme.of(context).textTheme.headline5,
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
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        size: 18,
                                        color: Colors.grey[400],
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
                                      const SizedBox(width: 4),
                                      Text(
                                        restaurant.city,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              color: const Color(0xFF616161),
                                            ),
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${restaurant.rating}',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
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
                                    const SizedBox(width: 4),
                                    RatingBarIndicator(
                                      rating: restaurant.rating,
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemSize: 18,
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
                                  ],
                                ),
                                const SizedBox(height: 4),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(18),
                                          topRight: Radius.circular(18),
                                        ),
                                      ),
                                      builder: (context) {
                                        return ReviewCustomer(
                                          provider: provider,
                                          restaurant: restaurant,
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Lihat Review',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                            color: primaryColor,
                                            decoration:
                                                TextDecoration.underline),
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
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Kategori :',
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                            .animate()
                            .fade(
                              duration: 850.ms,
                            )
                            .slideX(
                              begin: -0.3,
                              duration: 1200.ms,
                              curve: Curves.fastOutSlowIn,
                            ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 35,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: restaurant.categories.map((category) {
                              return Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    category.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                  )
                                      .animate()
                                      .fade(
                                        duration: 850.ms,
                                      )
                                      .slideX(
                                        begin: -0.3,
                                        duration: 1200.ms,
                                        curve: Curves.fastOutSlowIn,
                                      ),
                                ),
                              )
                                  .animate()
                                  .fade(
                                    duration: 850.ms,
                                  )
                                  .slideX(
                                    begin: -0.3,
                                    duration: 1200.ms,
                                    curve: Curves.fastOutSlowIn,
                                  );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Deskripsi :',
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                            .animate()
                            .fade(
                              duration: 850.ms,
                            )
                            .slideX(
                              begin: -0.3,
                              duration: 1200.ms,
                              curve: Curves.fastOutSlowIn,
                            ),
                        const SizedBox(height: 4),
                        Text(
                          restaurant.description,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                            .animate()
                            .fade(
                              duration: 850.ms,
                            )
                            .slideY(
                              begin: 0.4,
                              duration: 1200.ms,
                              curve: Curves.fastOutSlowIn,
                            ),
                        const SizedBox(height: 15),
                        Text(
                          'Menu Makanan :',
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                            .animate()
                            .fade(
                              duration: 850.ms,
                            )
                            .slideX(
                              begin: -0.3,
                              duration: 1200.ms,
                              curve: Curves.fastOutSlowIn,
                            ),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 180,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 8,
                            ),
                            children: restaurant.menus.foods.map((food) {
                              return CardMenu(
                                image: 'assets/images/food.png',
                                name: food.name,
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Menu Minuman :',
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                            .animate()
                            .fade(
                              duration: 850.ms,
                            )
                            .slideX(
                              begin: -0.3,
                              duration: 1200.ms,
                              curve: Curves.fastOutSlowIn,
                            ),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 180,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 8,
                            ),
                            children: restaurant.menus.drinks.map((drink) {
                              return CardMenu(
                                image: 'assets/images/drink.png',
                                name: drink.name,
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
