import 'package:flutter/cupertino.dart';

import 'WalletState.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  // This widget is the home page of Walletr application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  static const routeName = '/Wallet';

  @override
  State<Wallet> createState() => WalletState();
}
