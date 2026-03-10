import 'package:canteen_bite_mobile/RouteRegistry.dart';
import 'package:canteen_bite_mobile/splash/Splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: Splash.routeName,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple),),
      routes: RouteRegistry.routes,
    );
  }
}
