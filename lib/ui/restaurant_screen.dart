import 'package:flutter/material.dart';
import 'package:tosik/data/model/restaurant_model.dart';
import 'package:tosik/ui/restaurant_detail.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});
  static const routeName = '/restaurant_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tongkrongan Asik"),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          final List<RestaurantModel> restaurants =
              parseRestaurants(snapshot.data);

          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return _itemList(context, restaurant);
            },
          );
        },
      ),
    );
  }

  Widget _itemList(BuildContext context, RestaurantModel restaurants) {
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
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 100,
                width: 125,
                child: restaurants.pictureId == null
                    ? Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.grey[400],
                      )
                    : Image.network(
                        restaurants.pictureId!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
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
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.broken_image,
                            size: 100,
                            color: Colors.grey[400],
                          );
                        },
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
                    "${restaurants.name}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
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
                      Text(
                        '${restaurants.city}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: const Color(0xFF616161)),
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
                    ],
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
