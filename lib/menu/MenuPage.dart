import 'package:canteen_bite_mobile/model/Category.dart';
import 'package:flutter/cupertino.dart';

import '../Dashboard/Home/HomeState.dart';
import 'MenuPageState.dart';

class MenuPage extends StatefulWidget {
  final Category? category;
  const MenuPage({super.key,  this.category});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  static const routeName = '/MenuPage';

  @override
  State<MenuPage> createState() => MenuPageState();
}
