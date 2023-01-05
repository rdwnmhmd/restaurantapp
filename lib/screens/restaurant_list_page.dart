import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screens/search_page.dart';
import '../api/api.dart';
import '../provider/list_restaurant_provider.dart';
import 'card_restaurant.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantListProvider>(
      create: (_) => RestaurantListProvider(apiService: ApiService()),
      child: Scaffold(
        body: Consumer<RestaurantListProvider>(
          builder: (context, state, _) {
            if (state.state == ListResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ListResultState.hasData) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Restaurant',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                Text(
                                  'Which restaurant would you like to visit?',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.search,
                                  color: Colors.blue, size: 35),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SearchRestaurantScreen.routeName);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.restaurantResult.restaurants.length,
                          itemBuilder: (context, index) {
                            var restaurant =
                                state.restaurantResult.restaurants[index];
                            return CardRestaurant(restaurant: restaurant);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state.state == ListResultState.noData) {
              return Center(
                child: Material(
                  child: Text(state.message),
                ),
              );
            } else if (state.state == ListResultState.error) {
              return Center(
                child: Material(
                  child: Text(state.message),
                ),
              );
            } else {
              return const Center(
                child: Material(
                  child: Text(''),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
