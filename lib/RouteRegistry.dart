import 'package:canteen_bite_mobile/Dashboard/Dashboard.dart';
import 'package:canteen_bite_mobile/OtpVerification/OtpVerification.dart';
import 'package:canteen_bite_mobile/login/Login.dart';
import 'package:canteen_bite_mobile/profile/Profile.dart';
import 'package:canteen_bite_mobile/splash/Splash.dart';
import 'package:flutter/material.dart';

class RouteRegistry {
  static Map<String, WidgetBuilder> get routes {
    return {
      Splash.routeName: (context) => const Splash(),
      Login.routeName: (context) => const Login(),
      OtpVerification.routeName: (context) => const OtpVerification(),
      Profile.routeName: (context) => const Profile(),
      Dashboard.routeName : (context) => const Dashboard()
    };
  }
}