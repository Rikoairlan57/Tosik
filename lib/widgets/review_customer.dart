// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tosik/widgets/card_review.dart';

import '../common/styles.dart';
import '../data/model/restaurant_detail_model.dart';
import '../provider/restaurant_detail_provider.dart';

class ReviewCustomer extends StatelessWidget {
  final RestaurantDetailModel restaurant;
  final RestaurantDetailProvider provider;

  const ReviewCustomer({
    super.key,
    required this.restaurant,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  )
                      .animate()
                      .fade(
                        duration: 850.ms,
                      )
                      .slideX(
                        begin: -0.5,
                        duration: 1200.ms,
                        curve: Curves.fastOutSlowIn,
                      ),
                  const SizedBox(width: 16),
                  Text(
                    'Review',
                    style: Theme.of(context).textTheme.headline6,
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return CardReview(
                          provider: provider,
                          restaurantId: restaurant.id,
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Tambah Review',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 6),
            children: restaurant.customerReviews.map((review) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: primaryColor,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
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
                          ),
                      title: Text(
                        review.name,
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
                      subtitle: Text(
                        review.date,
                      )
                          .animate()
                          .fade(
                            duration: 850.ms,
                          )
                          .slideY(
                            begin: 0.3,
                            duration: 1200.ms,
                            curve: Curves.fastOutSlowIn,
                          ),
                    ),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        review.review,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
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
                    ),
                  ],
                ),
              )
                  .animate()
                  .fade(
                    duration: 850.ms,
                  )
                  .slideY(
                    begin: 0.3,
                    duration: 1200.ms,
                    curve: Curves.fastOutSlowIn,
                  );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
