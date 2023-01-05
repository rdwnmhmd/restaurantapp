import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/search_page.dart';
import 'common/texttheme.dart';
import 'model/restaurant_list.dart';
import 'screens/detail_page.dart';
import 'screens/restaurant_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant App',
        theme: ThemeData(
          textTheme: myTextTheme,
          primaryColor: Colors.amber,
          // brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: RestaurantListPage.routeName,
        routes: {
          RestaurantListPage.routeName: (context) => const RestaurantListPage(),
          DetailRestorant.routeName: (context) => DetailRestorant(
                id: ModalRoute.of(context)!.settings.arguments as String,
                // restaurant:
                //     ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
          SearchRestaurantScreen.routeName: (context) =>
              SearchRestaurantScreen(),
        });
  }
}
