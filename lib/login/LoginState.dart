import 'dart:collection';

import 'package:canteen_bite_mobile/OtpVerification/OtpVerification.dart';
import 'package:canteen_bite_mobile/utils/Constants.dart';
import 'package:canteen_bite_mobile/utils/GlobalData.dart';
import 'package:canteen_bite_mobile/utils/view/AccentlButton.dart';
import 'package:flutter/material.dart';

import '../utils/ShowErrorException.dart';
import '../utils/network/NetworkException.dart';
import '../webservice/ApiCall.dart';
import 'Login.dart';

class LoginState extends State<Login> {

  final TextEditingController mobileController = TextEditingController();

  Future<void> sendOTP() async {
    ApiCall apiCall = ApiCall();

    Map<String, dynamic> request = HashMap();
    request.addAll({
      "apikey":Constants.apiKey,
      "mobileNumber": mobileController.text.trim()
    });

    GlobalData.showProgressDialog(context);

    try {
      String response =  await apiCall.sendOtp(request);
      GlobalData.hideProgressDialog(context);
      if(response!=null && response.isNotEmpty){
        Navigator.popAndPushNamed(context, OtpVerification.routeName,
        arguments: OTPVerificationArguments(mobile_number: mobileController.text.trim(),
            otp_code: response));

      }
    }  on NetworkException catch(networkException) {
      if(context.mounted){
        GlobalData.hideProgressDialog(context);
        GlobalData.showOkayDialog(context, networkException.toString());
      }
    } on ShowErrorException catch(exception) {
      if(context.mounted){
        GlobalData.hideProgressDialog(context);
        GlobalData.showOkayDialog(context, exception.message!);
      }
    } catch(exception) {
      if(context.mounted){
        GlobalData.hideProgressDialog(context);
        GlobalData.showOkayDialog(context, exception.toString());
      }
    }
  }

  @override
Widget build(BuildContext context) {
 return Scaffold(
   resizeToAvoidBottomInset: true,
    body: Container(
        width: double.infinity,
        height: double.infinity,
      decoration: BoxDecoration(
       color:  Color(0xFFFE9D1D),
          image: DecorationImage(
            image: const AssetImage('assets/images/food_doodle.png'),
            repeat: ImageRepeat.repeat,
            colorFilter: ColorFilter.mode(
              Colors.white.withValues(alpha: 0.4),
              BlendMode.srcIn,
            ),)
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Image.asset("assets/images/logo.png",height: 200,),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.sizeOf(context).width-60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(
                children: [
                  Text("Login",
                    style: TextStyle(fontFamily: "poppins_semibold",
                        fontSize: 18,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                      decorationThickness: 1.5
                    ),
                    textAlign: TextAlign.center,),
                  SizedBox(height: 20,),
                  Text("Please enter your mobile number for further proceess.",
                  style: TextStyle(fontFamily: "poppins",
                  fontSize: 16),
                  textAlign: TextAlign.start,),

                  SizedBox(height: 20,),
                TextField(
                  controller: mobileController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                            filled: true,
                            prefixText: "+91  ",
                            prefixStyle:  TextStyle(fontFamily: "poppins",fontSize: 17),
                             fillColor: Colors.white,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFFE9D1D), width: 2),
                            ),
                            ),
                            ),
                SizedBox(height: 8,),
                Text("*We will send you an OTP to his number for verification.",
                  style: TextStyle(fontFamily: "poppins",
                  color: Colors.grey,
                  fontSize: 13),
                  textAlign: TextAlign.start,),

                  SizedBox(height: 20,),
                  AccentButton(buttonText: "Verify", onPressed: (){
                    if(mobileController.text.length !=10){
                      GlobalData.showOkayDialog(context, "Please enter correct mobile number");
                    }else {
                      sendOTP();
                    }
                    })

                ],
              ),
            ),



          ],
        ),
      )
  ));
}
}
