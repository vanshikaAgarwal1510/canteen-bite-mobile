import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'Constants.dart';


class LocalDataStore {
  static SharedPreferences? localStorage;

  LocalDataStore getInstance() {
    getPreference();
    return this;
  }

  Future<LocalDataStore> getAwaitInstance() async {
    await getPreference();
    return this;
  }

  Future<SharedPreferences> getPreference() async {
    localStorage ??= await SharedPreferences.getInstance();
    return localStorage!;
  }

  void setApiKey(String apiKey) async {
    await localStorage?.setString("apiKey", apiKey);
  }

  String? getApiKey() {
    if ((localStorage?.getString("apiKey") == null)) {
      return Constants.BLANK;
    } else {
      return (localStorage?.getString("apiKey"));
    }
  }

  void setDeviceType(int device_type) async {
    await localStorage?.setInt("device_type", device_type);
  }

  int? getDeviceType() {
    if ((localStorage?.getInt("device_type") == null)) {
      return -1;
    } else {
      return (localStorage?.getInt("device_type"));
    }
  }

  void setDeviceOs(String deviceOS) async {
    await localStorage?.setString("device_os", deviceOS);
  }

  String? getDeviceOs() {
    if ((localStorage?.getString("device_os") == null)) {
      return Constants.BLANK;
    } else {
      return (localStorage?.getString("device_os"));
    }
  }

  void setAppVersion(String deviceOS) async {
    await localStorage?.setString("app_version", deviceOS);
  }

  String? getAppVersion() {
    if ((localStorage?.getString("app_version") == null)) {
      return Constants.BLANK;
    } else {
      return (localStorage?.getString("app_version"));
    }
  }

  void setDeviceModel(String deviceModel) async {
    await localStorage?.setString("device_model", deviceModel);
  }

  String? getDeviceModel() {
    if ((localStorage?.getString("device_model") == null)) {
      return Constants.BLANK;
    } else {
      return (localStorage?.getString("device_model"));
    }
  }

  void setDeviceToken(String device_token) async {
    await localStorage?.setString("device_token", device_token);
  }

  String? getDeviceToken() {
    if ((localStorage?.getString("device_token") != null)) {
      if((localStorage?.getString("device_token"))!.isNotEmpty){
        if((localStorage?.getString("device_token"))! == "1234"){
          return "1234";
        } else {
          return (localStorage?.getString("device_token"));
        }
      } else {
        return "1234";
      }

    } else {
      return "1234";
    }
  }

  void setDeviceDetailsId(String device_details_id) async {
    await localStorage?.setString("device_details_id", device_details_id);
  }

  String? getDeviceDetailsId() {
    if ((localStorage?.getString("device_details_id") == null)) {
      return Constants.BLANK;
    } else {
      return (localStorage?.getString("device_details_id"));
    }
  }

  void setAuthToken(String auth_token) async {
    await localStorage?.setString("auth_token", auth_token);
  }

  String? getAuthToken() {
    if ((localStorage?.getString("auth_token") == null)) {
      return Constants.BLANK;
    } else {
      return (localStorage?.getString("auth_token"));
    }
  }

  void setNameOfUser(String name_of_user) async {
    await localStorage?.setString("name_of_user", name_of_user);
  }

  String? getNameOfUser() {
    if ((localStorage?.getString("name_of_user") == null)) {
      return Constants.BLANK;
    } else {
      return (localStorage?.getString("name_of_user"));
    }
  }

  void setUserImage(String user_image) async {
    await localStorage?.setString("user_image", user_image);
  }

  String? getUserImage() {
    if ((localStorage?.getString("user_image") == null)) {
      return Constants.BLANK;
    } else {
      return (localStorage?.getString("user_image"));
    }
  }

  void setUserEmail(String user_email) async {
    await localStorage?.setString("user_email", user_email);
  }

  String? getUserEmail() {
    if ((localStorage?.getString("user_email") == null)) {
      return Constants.BLANK;
    } else {
      return (localStorage?.getString("user_email"));
    }
  }

  void setEmailVerified(bool is_verified) async {
    await localStorage?.setBool("is_verified", is_verified);
  }

  bool? getEmailVerified() {
    if ((localStorage?.getBool("is_verified") == null)) {
      return false;
    } else {
      return (localStorage?.getBool("is_verified"));
    }
  }


  void setUserCountryCode(String user_country_code) async {
    await localStorage?.setString("user_country_code", user_country_code);
  }

  String? getUserCountryCode() {
    if ((localStorage?.getString("user_country_code") == null)) {
      return Constants.BLANK;
    } else {
      return (localStorage?.getString("user_country_code"));
    }
  }

  void setUserReferralCode(String referral_code) async {
    await localStorage?.setString("referral_code", referral_code);
  }

  String? getUserReferralCode() {
    if ((localStorage?.getString("referral_code") == null)) {
      return Constants.BLANK;
    } else {
      return (localStorage?.getString("referral_code"));
    }
  }

  void setUserMobile(String user_email) async {
    await localStorage?.setString("user_mobile", user_email);
  }

  String? getUserMobile() {
    if ((localStorage?.getString("user_mobile") == null)) {
      return Constants.BLANK;
    } else {
      return (localStorage?.getString("user_mobile"));
    }
  }

  void setAppSignature(String app_signature) async {
    await localStorage?.setString("app_signature", app_signature);
  }

  String? getAppSignature() {
    if ((localStorage?.getString("app_signature") == null)) {
      return "mAcEKQOJy+H2";
     // return "gvUQXxiq0nT";
    } else {
      return (localStorage?.getString("app_signature"));
    }
  }

  void logoutUser() {
    setUserMobile(Constants.BLANK);
    setUserReferralCode(Constants.BLANK);
    setUserCountryCode(Constants.BLANK);
    setUserEmail(Constants.BLANK);
    setNameOfUser(Constants.BLANK);
    setAuthToken(Constants.DEFAULT_TOKEN);
  }


}
