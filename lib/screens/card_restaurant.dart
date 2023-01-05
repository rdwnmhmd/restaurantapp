import 'package:flutter/material.dart';
import '../model/restaurant_list.dart';
import 'detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  const CardRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: Hero(
          tag:
              "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                // width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Text(
          restaurant.name ?? "",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.blueAccent,
                  size: 20,
                ),
                Text(
                  restaurant.city ?? "",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.amber,
                ),
                Text('${restaurant.rating}'),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, DetailRestorant.routeName,
              arguments: restaurant.id);
        },
      ),
    );
  }
}
