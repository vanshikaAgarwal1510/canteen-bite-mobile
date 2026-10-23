import 'package:canteen_bite_mobile/model/Category.dart';
import 'package:flutter/cupertino.dart';

import 'HomeState.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  static const routeName = '/Home';

  @override
  State<Home> createState() => HomeState();
}

