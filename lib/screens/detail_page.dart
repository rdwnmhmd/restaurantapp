import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/restaurant_list.dart';
import '../api/api.dart';
import '../provider/detail_restaurant.dart';

class DetailRestorant extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final String id;
  const DetailRestorant({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
        create: (_) =>
            DetailRestaurantProvider(apiService: ApiService(), id: id),
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.grey,
          // ),
          body: SafeArea(
            child: Consumer<DetailRestaurantProvider>(
                builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.network(
                              'https://restaurant-api.dicoding.dev/images/large/${state.result.restaurant.pictureId}'),
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.blueAccent,
                                    ),
                                    Text(
                                      '${state.result.restaurant.city}',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                        state.result.restaurant.rating
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium)
                                  ],
                                ),
                              ],
                            ),
                            const Divider(color: Colors.black),
                            Text(
                              '${state.result.restaurant.description}',
                              textAlign: TextAlign.justify,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const Divider(color: Colors.black),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state.state == ResultState.noData ||
                  state.state == ResultState.error ||
                  state.state == ResultState.noConnection) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 8),
                      Text(state.message),
                      const SizedBox(height: 8),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Back'))
                    ],
                  ),
                );
              } else {
                return const Center(child: Text(''));
              }
            }),
          ),
        ));
  }
}
