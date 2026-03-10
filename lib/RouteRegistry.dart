import 'package:canteen_bite_mobile/splash/Splash.dart';
import 'package:flutter/material.dart';

class RouteRegistry {
  static Map<String, WidgetBuilder> get routes {
    return {
      Splash.routeName: (context) => const Splash(),

    };
  }
}