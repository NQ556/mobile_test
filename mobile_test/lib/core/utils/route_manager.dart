import 'package:flutter/material.dart';
import 'package:mobile_test/core/common/entities/user.dart';
import 'package:mobile_test/features/home/presentation/pages/home_page.dart';
import 'package:mobile_test/features/auth/presentation/pages/sign_in_page.dart';

class Routes {
  static const String signInRoute = "/";
  static const String homeRoute = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.signInRoute:
        return MaterialPageRoute(
          builder: (_) => SignInPage(),
        );

      case Routes.homeRoute:
        if (routeSettings.arguments is User) {
          final args = routeSettings.arguments as User;

          return MaterialPageRoute(
            builder: (_) => HomePage(
              user: args,
            ),
          );
        }
        return unDefinedRoute();

      default:
        return unDefinedRoute();
    }
  }
}

Route<dynamic> unDefinedRoute() {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      appBar: AppBar(
        title: Text("No Route Found"),
      ),
      body: Center(
        child: Text("No Route Found"),
      ),
    ),
  );
}
