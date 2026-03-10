import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScrollUtil extends MaterialScrollBehavior {
  // Override behavior to allow both touch and mouse dragging
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}