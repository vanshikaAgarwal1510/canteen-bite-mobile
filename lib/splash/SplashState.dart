import 'dart:collection';

import 'package:canteen_bite_mobile/login/Login.dart';
import 'package:canteen_bite_mobile/profile/Profile.dart';
import 'package:canteen_bite_mobile/webservice/response/InitResponse.dart';
import 'package:flutter/material.dart';

import '../Dashboard/Dashboard.dart';
import '../Dashboard/you/You.dart';
import '../utils/Constants.dart';
import '../utils/GlobalData.dart';
import '../utils/ShowErrorException.dart';
import '../utils/network/NetworkException.dart';
import '../webservice/ApiCall.dart';
import 'Splash.dart';

class SplashState extends State<Splash>{

  @override
  void initState() {
    super.initState();
    GlobalData.localDataStore.getAwaitInstance();
    initData();
  }

  Future<void> initData() async {
    ApiCall apiCall = ApiCall();

    Map<String, dynamic> request = HashMap();
    request.addAll({
      "apikey":Constants.apiKey,
    });

    try {
      InitResponse response =  await apiCall.initData(request);
    if(response.userData==null){
      Navigator.popAndPushNamed(context, Login.routeName);
    }else if (response.userData!.name =='New User'){
      Navigator.popAndPushNamed(context, Profile.routeName);
    }
    else{
      Navigator.popAndPushNamed(context, Dashboard.routeName);
    }
    }  on NetworkException catch(networkException) {
      if(context.mounted){
        GlobalData.showOkayDialog(context, networkException.toString());
      }
    } on ShowErrorException catch(exception) {
      if(context.mounted){
         GlobalData.showOkayDialog(context, exception.message!);
      }
    } catch(exception) {
      if(context.mounted){
        GlobalData.showOkayDialog(context, exception.toString());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image:
              AssetImage("assets/images/splash.png"),
            fit: BoxFit.cover
          )
        ),
    ));
  }

}