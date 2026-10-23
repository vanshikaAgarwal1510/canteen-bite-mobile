import 'package:get/get.dart';

class Constants {

  static String GOOGLE_API_KEY = "AIzaSyCb5OO_D_bzz3gXG5p1uQfd72pm12gciaQ";

  static String URL_SHARE = "https://google.co.in/";
  static String URL_RATE_US = "https://www.tapandtrade.net/";
  static String URL_FAQs = "https://www.tapandtrade.net/";
  static String URL_TERMS_OF_USE = "https://www.tapandtrade.net/terms";
  static String URL_PRIVAY_POLICY = "https://www.tapandtrade.net/privacy-policy";
  static String URL_DATA_POLICY = "https://www.tapandtrade.net/terms";
  static String URL_CONTACT_US = "https://www.tapandtrade.net/support";
  static String URL_ABOUT_US = "https://www.tapandtrade.net/";
  static String URL_GOOGLE_APP = "https://play.google.com/store/apps/details?id=tap.trade.com";
  static String URL_APPLE_APP = "https://apps.apple.com/in/app/taptrade/id6753078650";
  static bool SEND_OTP = true;
  static String DEFAULT_TOKEN ="ae4ca383492084d4e285f0477662a499";
  static String apiKey="campusBite@123";
  static String BASE_URL = "http://10.0.3.2:5123";


  static RegExp validEmailRegex =RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static int EMAIL_AVAILABLITY_STATE_LOADING = 1;
  static int EMAIL_AVAILABLITY_STATE_AVAILABLE = 2;
  static int EMAIL_AVAILABLITY_STATE_NOT_AVAILABLE = 3;
  static int EMAIL_AVAILABLITY_STATE_SAME = 4;
  static int EMAIL_AVAILABLITY_STATE_UNKNOWN = 5;
  static int EMAIL_AVAILABLITY_STATE_INVALID_EMAIL = 6;

  static double fontSizeOverSmall = Get.context!.width >= 1300 ? 10 : 8;
  static double fontSizeExtraSmall = Get.context!.width >= 1300 ? 12 : 10;
  static double fontSizeSmall = Get.context!.width >= 1300 ? 14 : 12;
  static double fontSizeDefault = Get.context!.width >= 1300 ? 16 : 14;
  static double fontSizeLarge = Get.context!.width >= 1300 ? 18 : 16;
  static double fontSizeExtraLarge = Get.context!.width >= 1300 ? 20 : 18;
  static double fontSizeOverLarge = Get.context!.width >= 1300 ? 26 : 24;

  static const double paddingSizeExtraSmall = 8.0;
  static const double paddingSizeSmall = 12.0;
  static const double paddingSizeDefault = 14.0;
  static const double paddingSizeLarge = 18.0;
  static const double paddingSizeExtraLarge = 20.0;
  static const double paddingSizeExtremeLarge = 24.0;

  static const double radiusSmall = 8.0;
  static const double radiusDefault = 10.0;
  static const double radiusLarge = 16.0;
  static const double radiusExtraLarge = 20.0;

  static const double webMaxWidth = 1170;
  static const int messageInputLength = 250;

  static const int DEVICE_TYPE_UNKNOWN = -1;
  static const int DEVICE_TYPE_ANDROID = 1;
  static const int DEVICE_TYPE_IOS = 2;
  static const int DEVICE_TYPE_WEB = 3;

  static const int SCREEN_TYPE_UNKNOWN = -1;
  static const int SCREEN_TYPE_MOBILE = 1;
  static const int SCREEN_TYPE_TABLET = 2;
  static const int SCREEN_TYPE_WEBSITE = 3;

  static String BLANK = "";

}
