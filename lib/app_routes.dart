import 'package:flutter/material.dart';
import 'package:movies_app/domain/entities/entities.dart';
import 'package:movies_app/presentation/pages/pages.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return HomePage.route();
      case "/movie_page":
        return MoviePage.route(
          movie: settings.arguments as Movie,
        );
      case "/search_page":
        return SearchPage.route();
      default:
        return HomePage.route();
    }
  }
}
