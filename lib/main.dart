import 'package:canteen_bite_mobile/RouteRegistry.dart';
import 'package:canteen_bite_mobile/splash/Splash.dart';
import 'package:canteen_bite_mobile/utils/GlobalData.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalData.localDataStore.getAwaitInstance();
  await GlobalData.cartModel.loadCart();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Bite',
      initialRoute: Splash.routeName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: RouteRegistry.routes,
    );
  }
}
