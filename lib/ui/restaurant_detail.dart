// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tosik/data/model/restaurant_list_model.dart';

class RestaurantDetail extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final RestaurantModel restaurant;

  const RestaurantDetail({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: restaurant.pictureId,
                child: Container(
                  height: heightScreen * 0.4,
                  width: widthScreen,
                  margin: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(restaurant.pictureId),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
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
                                style: Theme.of(context).textTheme.headline5,
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
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    size: 18,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "${restaurant.city}",
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
                                      )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        RatingBarIndicator(
                          rating: restaurant.rating,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemSize: 20,
                        )
                            .animate()
                            .fade(
                              duration: 850.ms,
                            )
                            .slideY(
                              begin: -0.3,
                              duration: 1200.ms,
                              curve: Curves.fastOutSlowIn,
                            )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Description :",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
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
                          begin: -0.3,
                          duration: 1200.ms,
                          curve: Curves.fastOutSlowIn,
                        ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Food :',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(
          top: 15,
        ),
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
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
          .slideX(
            begin: -0.3,
            duration: 600.ms,
            curve: Curves.fastOutSlowIn,
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget _itemMenu(String image, String? name) {
    return Container(
      height: 200,
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              height: 80,
              width: 80,
            ).animate().shake(
                  // delay: 500.ms,
                  hz: 4,
                  duration: 1000.ms,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Text(
              '$name',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
