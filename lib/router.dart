import 'package:bookslib/common/widgets/bottom_bar.dart';
import 'package:bookslib/features/admin/screens/add_product_screen.dart';
import 'package:bookslib/features/auth/screens/landing_screen.dart';
import 'package:bookslib/features/home/screens/category_deals_screen.dart';
import 'package:bookslib/features/home/screens/home_screen.dart';
import 'package:bookslib/features/product_details/screens/product_detail_screen.dart';
import 'package:bookslib/features/search/screens/search_screen.dart';
import 'package:bookslib/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case LandingScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LandingScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );

    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(category: category),
      );

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchQuery: searchQuery),
      );

    case ProductDetailScreen.routeName:
      var prodcut = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(product: prodcut),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
