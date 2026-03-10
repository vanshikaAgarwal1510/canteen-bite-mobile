import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';
import 'GlobalData.dart';

class DeviceUtil {

  Future<DeviceInfoPlugin> getDeviceInfo(BuildContext context) async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Theme.of(context).platform == TargetPlatform.iOS) {

      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      String deviceModel = iosDeviceInfo.utsname.machine;
      debugPrint("Device Model is $deviceModel");

      GlobalData.localDataStore.setDeviceType(Constants.DEVICE_TYPE_IOS);
      GlobalData.localDataStore.setDeviceModel(deviceModel);
      GlobalData.localDataStore.setDeviceOs(iosDeviceInfo.systemVersion);


    } else if (Theme.of(context).platform == TargetPlatform.android) {

      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      String deviceModel = "${androidDeviceInfo.brand}, ${androidDeviceInfo.model}";
      debugPrint("Device Model is $deviceModel");

      GlobalData.localDataStore.setDeviceType(Constants.DEVICE_TYPE_ANDROID);
      GlobalData.localDataStore.setDeviceModel(deviceModel);
      GlobalData.localDataStore.setDeviceOs(androidDeviceInfo.version.release);

    } else {

      WebBrowserInfo webBrowserInfo = await deviceInfoPlugin.webBrowserInfo;
      String deviceModel = webBrowserInfo.userAgent!;
      debugPrint("Device Model is $deviceModel");

      GlobalData.localDataStore.setDeviceType(Constants.DEVICE_TYPE_WEB);
      GlobalData.localDataStore.setDeviceModel(deviceModel);
      GlobalData.localDataStore.setDeviceOs("${webBrowserInfo.appName}, ${webBrowserInfo.appVersion!}");

    }

    if(MediaQuery.of(context).size.width < 650){

      GlobalData.screenType = Constants.SCREEN_TYPE_MOBILE;

    } else if(
          MediaQuery.of(context).size.width < 1100
        && MediaQuery.of(context).size.width >= 650
    ){

      GlobalData.screenType = Constants.SCREEN_TYPE_TABLET;

    } else if (MediaQuery.of(context).size.width >= 1100) {

      GlobalData.screenType = Constants.SCREEN_TYPE_WEBSITE;

    }

    return deviceInfoPlugin;
  }
}