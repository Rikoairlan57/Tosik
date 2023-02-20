// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tosik/ui/restaurant_detail.dart';
import 'package:tosik/data/model/restaurant_list_model.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurants;

  const RestaurantCard({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RestaurantDetail.routeName,
          arguments: restaurants,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: restaurants.pictureId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 100,
                  width: 125,
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/small/${restaurants.pictureId}',
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey[400],
                          ),
                        );
                      }
                    },
                    errorBuilder: (_, __, ___) {
                      return Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.grey[400],
                      );
                    },
                  ).animate().shake(
                        // delay: 500.ms,
                        hz: 4,
                        duration: 500.ms,
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
                    ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    restaurants.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.w500,
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
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        size: 18,
                        color: Colors.grey[400],
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
                      Text(
                        restaurants.city,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: const Color(0xFF616161)),
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
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${restaurants.rating}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: const Color(0xFF616161)),
                      ),
                    ]
                        .animate()
                        .fade(
                          duration: 750.ms,
                        )
                        .slideX(
                          begin: -0.3,
                          duration: 600.ms,
                          curve: Curves.fastOutSlowIn,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
