import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/api.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/screens/home_page.dart';
import 'package:restaurant_app/screens/list_card_search.dart';

import 'card_restaurant.dart';

class SearchRestaurantScreen extends StatefulWidget {
  static const routeName = '/restaurant_search';
  @override
  _SearchRestaurantScreenState createState() => _SearchRestaurantScreenState();
}

class _SearchRestaurantScreenState extends State<SearchRestaurantScreen> {
  String queries = '';
  TextEditingController _controller = TextEditingController();

  Widget _listSearchRestaurants(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(
        serviceAPISearch: ApiService(),
      ),
      child: Consumer<SearchRestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == StateResultSearch.loading) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearProgressIndicator(
                    minHeight: 5,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Memuat Data Restoran...',
                      style: Theme.of(context).textTheme.subtitle1)
                ],
              ),
            );
          } else if (state.state == StateResultSearch.hasData) {
            state.fetchAllRestaurantSearch(queries);
            return Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result?.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result!.restaurants[index];

                    return RestaurantsListCardSearch(restaurant: restaurant);
                  },
                ));
          } else if (state.state == StateResultSearch.noData) {
            state.fetchAllRestaurantSearch(queries);

            return Center(child: Text(state.message));
          } else if (state.state == StateResultSearch.error) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text(''));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
        return true;
      },
      child: SafeArea(
          child: Scaffold(
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  height: 28.0,
                  left: 0.0,
                  right: 0.0,
                  child: connected
                      ? Visibility(
                          visible: true,
                          child: Container(),
                        )
                      : Container(
                          color: Colors.red,
                          child: Center(
                            child: Text(
                              "Koneksi Internet Kamu Hilang :(",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                    (route) => false);
                              },
                              icon: Icon(Icons.arrow_back_ios_new)),
                          Text(
                            'Cari Restoran',
                            style: Theme.of(context).textTheme.headline5,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ChangeNotifierProvider(
                        create: (_) => SearchRestaurantProvider(
                          serviceAPISearch: ApiService(),
                        ),
                        child: Consumer<SearchRestaurantProvider>(
                          builder: (context, state, _) {
                            return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30)),
                                child: ListTile(
                                    leading: Icon(
                                      Icons.search,
                                      size: 30,
                                    ),
                                    title: TextField(
                                      controller: _controller,
                                      onChanged: (String value) {
                                        setState(() {
                                          queries = value;
                                        });
                                        if (value != '') {
                                          state.fetchAllRestaurantSearch(value);
                                        }
                                      },
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                          hintText: "Cari Restoran Apa ?",
                                          border: InputBorder.none),
                                    ),
                                    trailing: IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed: () {
                                        if (queries != '') {
                                          _controller.clear();
                                          setState(() {
                                            queries = '';
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.close, size: 30),
                                    )));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: _listSearchRestaurants(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          child: Container(),
        ),
      )),
    );
  }
}
