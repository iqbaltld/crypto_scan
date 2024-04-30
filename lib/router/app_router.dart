import 'package:flutter/material.dart';
import 'package:crypto_scan/screens/home/home.dart';
import 'package:crypto_scan/screens/trends/trends.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/trends':
        final symbol = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) => TrendsPage(symbol: symbol));
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
