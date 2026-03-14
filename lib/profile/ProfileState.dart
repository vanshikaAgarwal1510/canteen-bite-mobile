import 'dart:collection';

import 'package:canteen_bite_mobile/OtpVerification/OtpVerification.dart';
import 'package:canteen_bite_mobile/utils/Constants.dart';
import 'package:canteen_bite_mobile/utils/GlobalData.dart';
import 'package:canteen_bite_mobile/utils/view/AccentlButton.dart';
import 'package:flutter/material.dart';

import '../Dashboard/Dashboard.dart';
import '../utils/ShowErrorException.dart';
import '../utils/network/NetworkException.dart';
import '../webservice/ApiCall.dart';
import 'Profile.dart';

class ProfileState extends State<Profile> {

  final TextEditingController nameController = TextEditingController();
  bool isUniversityStudent = true;

  Future<void> updateProfile() async {
    ApiCall apiCall = ApiCall();

    Map<String, dynamic> request = HashMap();
    request.addAll({
      "apikey":Constants.apiKey,
      "fullName": nameController.text.trim(),
      "isUniversityStudent":isUniversityStudent
    });

    GlobalData.showProgressDialog(context);

    try {
      dynamic response =  await apiCall.profile(request);
      GlobalData.hideProgressDialog(context);
      if(response!=null && response.isNotEmpty){
        GlobalData.localDataStore.setNameOfUser(response["fullName"]);
        GlobalData.localDataStore.setUserMobile(response['mobileNumber']);
        Navigator.popAndPushNamed(context, Dashboard.routeName);
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
                  Text("Profile",
                    style: TextStyle(fontFamily: "poppins_semibold",
                        fontSize: 18,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                      decorationThickness: 1.5
                    ),
                    textAlign: TextAlign.center,),
                  SizedBox(height: 20,),

                  Row(
                    children: [
                      SizedBox(width: 8,),
                      Text("Please enter your name.",
                      style: TextStyle(fontFamily: "poppins",
                      fontSize: 16),),
                    ],
                  ),

                  SizedBox(height: 5,),
                TextField(
                  controller: nameController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter your name",
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
                SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Are you university Student?",
                      style: TextStyle(fontFamily: "poppins",
                          fontSize: 16),
                      textAlign: TextAlign.start,),

                      _switch(isUniversityStudent, (value){
                        setState(() {
                          isUniversityStudent=value;
                        });
                      }),
                    ],
                  ),

                  SizedBox(height: 15,),
                  AccentButton(buttonText: "Continue", onPressed: (){
                    if(nameController.text.isEmpty){
                      GlobalData.showOkayDialog(context, "Please enter name");
                    }else {
                    updateProfile();
                    }
                    }),
                  SizedBox(height: 15,),
                 /* Text("Skip>>>",
                    style: TextStyle(fontFamily: "poppins_semibold",
                        fontSize: 16,
                    color: Colors.orange,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.deepOrange),
                    textAlign: TextAlign.center,),*/

                ],
              ),
            ),



          ],
        ),
      )
  ));
}

  Widget _switch( bool value , Function(bool) onChanged) {
    return Switch(
        thumbIcon: WidgetStatePropertyAll(Icon(Icons.circle,color: Color((0xFFEF9D1D)),)),
        activeThumbColor: Color(0xFFEF9D1D),
        activeTrackColor: Colors.white,
        inactiveThumbColor: Color(0xFFEF9D1D),
        inactiveTrackColor: Colors.white,
        trackOutlineColor: WidgetStatePropertyAll(Colors.grey.shade300),
        splashRadius: 0,
        value: value,
        onChanged: onChanged);
  }
}
