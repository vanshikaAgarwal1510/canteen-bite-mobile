import 'package:canteen_bite_mobile/Dashboard/Dashboard.dart';
import 'package:canteen_bite_mobile/Menu/MenuPage.dart';
import 'package:canteen_bite_mobile/OtpVerification/OtpVerification.dart';
import 'package:canteen_bite_mobile/contact/Contact.dart';
import 'package:canteen_bite_mobile/edit_profile/EditProfile.dart';
import 'package:canteen_bite_mobile/help/Help.dart';
import 'package:canteen_bite_mobile/login/Login.dart';
import 'package:canteen_bite_mobile/payment_method/PaymentMethod.dart';
import 'package:canteen_bite_mobile/profile/Profile.dart';
import 'package:canteen_bite_mobile/splash/Splash.dart';
import 'package:canteen_bite_mobile/status/Status.dart';
import 'package:canteen_bite_mobile/wallet/Wallet.dart';
import 'package:flutter/material.dart';

import 'Payment/Payment.dart';
import 'order_detail/OrderDetail.dart';

class RouteRegistry {
  static Map<String, WidgetBuilder> get routes {
    return {
      Splash.routeName: (context) => const Splash(),
      Login.routeName: (context) => const Login(),
      OtpVerification.routeName: (context) => const OtpVerification(),
      Profile.routeName: (context) => const Profile(),
      Dashboard.routeName : (context) => const Dashboard(),
      MenuPage.routeName:(context) => const MenuPage(),
      Payment.routeName:(context) => const Payment(),
      OrdersDetail.routeName:(context) => const OrdersDetail(),
      Status.routeName:(context) => const Status(),
      EditProfile.routeName:(context) => const EditProfile(),
      Wallet.routeName:(context) => const Wallet(),
      Contact.routeName:(context) => const Contact(),
      Help.routeName:(context) => const Help(),
      PaymentsMethod.routeName:(context) => const PaymentsMethod(),
    };
  }
}