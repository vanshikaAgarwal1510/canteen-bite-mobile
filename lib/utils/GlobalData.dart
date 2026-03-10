
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../dialog/DialogDoubleAction.dart';
import '../dialog/DialogSingleAction.dart';
import '../dialog/ProgressDialog.dart';
import 'LocalDataStore.dart';

import 'Constants.dart';

class GlobalData {
  static bool isAppLoggedIn = false;
  static LocalDataStore localDataStore = LocalDataStore().getInstance();
  static BaseDeviceInfo? deviceData;
  static BaseDeviceInfo? deviceModel;
  static int screenType = Constants.DEVICE_TYPE_UNKNOWN;


  static RegExp validEmailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);
  static ValueNotifier<int> cartLength = ValueNotifier<int>(0);
  static OverlayEntry? cartOverlayEntry = null;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static double xOffset = 80.0;
  static double yOffset = 300.0;
  static double overlayViewWidth = 200.0;
  static double overlayViewHeight = 60.0;
  static double bottomNavigationHeight = 200.0;
  static DialogSingleAction? netWorkErrorDialog;
  static ProgressDialog? progressDialog;
  static bool isProgressDialogShowing = false;



  static Future<void> showNetworkError(BuildContext context) async {
    if (netWorkErrorDialog == null) {
      netWorkErrorDialog = await showDialog(
        context: context,
        builder:
            (context) => DialogSingleAction(
              title: 'Campus Bite',
              message:
                  "Seems like your internet connection is not working, Please retry again after getting connected.",
              buttonText: "Ok",
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
      );
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      netWorkErrorDialog = null;
      showNetworkError(context);
    }
  }

  static Future<void> showProgressDialog(BuildContext context) async {
    if(!isProgressDialogShowing){

      isProgressDialogShowing = true;

      progressDialog = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => ProgressDialog(isDarkTheme: false),
      );
    }
  }

  static Future<void> hideProgressDialog(BuildContext context) async {

    if(isProgressDialogShowing){
      Navigator.of(context, rootNavigator: true).pop();
      progressDialog = null;
      isProgressDialogShowing = false;
    }
  }

  static void setScreenType(BuildContext context) {
    if (MediaQuery.of(context).size.width < 650) {
      GlobalData.screenType = Constants.SCREEN_TYPE_MOBILE;
    } else if (MediaQuery.of(context).size.width < 1100 &&
        MediaQuery.of(context).size.width >= 650) {
      GlobalData.screenType = Constants.SCREEN_TYPE_TABLET;
    } else if (MediaQuery.of(context).size.width >= 1100) {
      GlobalData.screenType = Constants.SCREEN_TYPE_WEBSITE;
    }
  }

  static void showSingleActionDialog(
    BuildContext context,
    String message,
    String action,
    VoidCallback onPressed,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => DialogSingleAction(
            title: 'Campus Bite',
            message: message,
            buttonText: action,
            onPressed: onPressed,
          ),
    );
  }

  static void showDoubleActionDialog(
    BuildContext context,
    String message,
    String leftAction,
    String rightAction,
    VoidCallback onPressedLeft,
    VoidCallback onPressedRight,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => DialogDoubleAction(
            title: 'Campus Bite',
            message: message,
            buttonTextLeft: leftAction,
            buttonTextRight: rightAction,
            onPressedLeft: onPressedLeft,
            onPressedRight: onPressedRight,
          ),
    );
  }

  static void showOkayDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => DialogSingleAction(
            title: 'Campus Bite',
            message: message,
            buttonText: "OK",
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
    );
  }



  static String convertToLocalDateTime(String gmtTime) {
    // Parse the GMT time string
    DateTime utcTime = DateTime.parse(gmtTime);

    // Convert to Local Time (IST in your case)
    DateTime localTime = utcTime.toLocal();

    // Format output
    DateFormat outputFormat = DateFormat("dd MMM yyyy hh:mm:a");
    return outputFormat.format(localTime);
  }

  static String convertToLocalTime(String gmtTime) {
    // Parse the GMT time string
    DateTime utcTime = DateTime.parse(gmtTime);

    // Convert to Local Time (IST in your case)
    DateTime localTime = utcTime.toLocal();

    // Format output
    DateFormat outputFormat = DateFormat("hh:mm:a");
    return outputFormat.format(localTime);
  }
  static String convertToLocalDate(String gmtTime) {
    // Parse the GMT time string
    DateTime utcTime = DateTime.parse(gmtTime);

    // Convert to Local Time (IST in your case)
    DateTime localTime = utcTime.toLocal();

    // Format output
    DateFormat outputFormat = DateFormat("dd MMM yyyy");
    return outputFormat.format(localTime);
  }


  static Future<File> copyFileToUploadableLocation(String cachePath) async {
    Directory directory = await getTemporaryDirectory();
    //final directory = await getCacheDirectory();
    final newPath = "${directory.path}/uploaded_image.jpg";
    final newFile = await File(cachePath).copy(newPath);
    return newFile;
  }

  /*static Future<File> copyFileToUploadableLocation(String cachePath) async {
    Directory directory = await getTemporaryDirectory();
    //final directory = await getCacheDirectory();
    final newPath = "${directory.path}/uploaded_image.jpg";
    final newFile = await File(cachePath).copy(newPath);
    return newFile;
  }
*/

  }
