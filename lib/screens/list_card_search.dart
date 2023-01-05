import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_list.dart';
import 'package:restaurant_app/screens/detail_page.dart';
import '../model/restaurant_search.dart';

class RestaurantsListCard extends StatelessWidget {
  final RestaurantSearch restaurant;
  RestaurantsListCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailRestorant(id: restaurant.id)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 25),
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  color: Colors.grey.withOpacity(0.3),
                  offset: Offset(0, 3))
            ]),
        child: Row(
          children: [
            Hero(
              tag: restaurant.pictureId,
              child: Container(
                width: 130,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://restaurant-api.dicoding.dev/images/medium/" +
                                restaurant.pictureId),
                        fit: BoxFit.fill)),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5),
                  child: Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_city,
                        color: Colors.blueAccent,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(restaurant.city),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.stars,
                        color: Colors.amber,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text("${restaurant.rating}"),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

//List For Search
class RestaurantsListCardSearch extends StatelessWidget {
  final RestaurantSearch restaurant;
  RestaurantsListCardSearch({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailRestorant(id: restaurant.id)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 25),
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  color: Colors.grey.withOpacity(0.3),
                  offset: Offset(0, 3))
            ]),
        child: Row(
          children: [
            Hero(
              tag: restaurant.pictureId,
              child: Container(
                width: 130,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://restaurant-api.dicoding.dev/images/medium/" +
                                restaurant.pictureId),
                        fit: BoxFit.fill)),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5),
                  child: Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_city,
                        color: Colors.blueAccent,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(restaurant.city),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.stars,
                        color: Colors.amber,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text("${restaurant.rating}"),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
