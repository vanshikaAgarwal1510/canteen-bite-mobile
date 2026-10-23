import 'dart:collection';

import 'package:canteen_bite_mobile/Dashboard/Dashboard.dart';
import 'package:canteen_bite_mobile/login/Login.dart';
import 'package:canteen_bite_mobile/profile/Profile.dart';
import 'package:canteen_bite_mobile/utils/view/AccentlButton.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../utils/Constants.dart';
import '../utils/GlobalData.dart';
import '../utils/ShowErrorException.dart';
import '../utils/network/NetworkException.dart';
import '../utils/view/ResendOTPView.dart';
import '../webservice/ApiCall.dart';
import '../webservice/response/OTPAuthenticateResponse.dart';
import 'OtpVerification.dart';

class OTPVerificationState extends State<OtpVerification>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  int levelClock = 50;
  String entered_otp_code = Constants.BLANK;
  String? verification_code;
  String? country_code;
  String? mobile_no;
  double ratio = 1.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: levelClock),
    );
    _animationController!.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        ratio = MediaQuery.of(context).devicePixelRatio;
        if (ratio < 3.0) {
          ratio = 3.0;
        }
      });

      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is OTPVerificationArguments) {
        setState(() {
          mobile_no = args.mobile_number;
          verification_code = args.otp_code;

          GlobalData.showOkayDialog(context, "OTP Code is $verification_code");
        });
      } else {
        debugPrint("Arguments not received correctly.");
      }
    });
  }

  Future<void> sendOTP() async {
    ApiCall apiCall = ApiCall();

    Map<String, dynamic> request = HashMap();
    request.addAll({
      "apikey": Constants.apiKey,
      "mobileNumber": mobile_no,
    });

    GlobalData.showProgressDialog(context);

    try {
      verification_code = await apiCall.sendOtp(request);
      GlobalData.hideProgressDialog(context);
      GlobalData.showOkayDialog(context, "OTP Code is $verification_code");
      _animationController!.reset();
      _animationController!.forward();
    } on Exception {
      GlobalData.showNetworkError(context);
    }
  }

  Future<void> authenticateOTP() async {
    ApiCall apiCall = ApiCall();
    Map<String, dynamic> request = HashMap();

    request.addAll({
      "apikey": Constants.apiKey,
      "mobileNumber": mobile_no,
      "otp": entered_otp_code,
    });

    GlobalData.showProgressDialog(context);
    try {
      OTPAuthenticateResponse response = await apiCall.authenticateOTP(request);
      GlobalData.hideProgressDialog(context);
      if (response.status == 200) {
        String fullName = response.data['user']['fullName'] ?? "New User";
        GlobalData.localDataStore.setNameOfUser(fullName);
        GlobalData.localDataStore.setUserMobile(
          response.data['user']['mobileNumber'],
        );
        GlobalData.localDataStore.setAuthToken(response.data['token']);

        if (fullName == "New User") {
          Navigator.popAndPushNamed(context, Profile.routeName);
        } else {
          Navigator.popAndPushNamed(context, Dashboard.routeName);
        }
      } else {
        GlobalData.showOkayDialog(
          context,
          response.message ?? "Authentication failed",
        );
      }
    } on NetworkException catch (networkException) {
      if (context.mounted) {
        GlobalData.hideProgressDialog(context);
        GlobalData.showOkayDialog(context, networkException.toString());
      }
    } on ShowErrorException catch (exception) {
      if (context.mounted) {
        GlobalData.hideProgressDialog(context);
        GlobalData.showOkayDialog(context, exception.message!);
      }
    } catch (exception) {
      if (context.mounted) {
        GlobalData.hideProgressDialog(context);
        GlobalData.showOkayDialog(context, exception.toString());
      }
    }
  }

  @override
  void dispose() {
    _animationController!.dispose();
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  void listenOtp() async {
    try {
      await SmsAutoFill().listenForCode();
    } on PlatformException catch (e) {
      debugPrint('SMS autofill unavailable: ${e.message}');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void onOTPResend() async {
    sendOTP();

    _animationController!.reset();
    _animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFFE9D1D),
          image: DecorationImage(
            image: const AssetImage('assets/images/food_doodle.png'),
            repeat: ImageRepeat.repeat,
            colorFilter: ColorFilter.mode(
              Colors.white.withValues(alpha: 0.4),
              BlendMode.srcIn,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset("assets/images/logo.png", height: 200),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.sizeOf(context).width - 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    const Text(
                      "OTP Verification",
                      style: TextStyle(
                        fontFamily: "poppins_semibold",
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                        decorationThickness: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: "poppins",
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "Enter the code that we sent\n to +91 $mobile_no. ",
                          ),
                          TextSpan(
                            text: "Change number",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontFamily: "poppins",
                              fontSize: 15,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                      context,
                                      Login.routeName,
                                    );
                                  },
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                      child: PinFieldAutoFill(
                        codeLength: 4,
                        currentCode: entered_otp_code,
                        textInputAction: TextInputAction.go,
                        autoFocus: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        cursor: Cursor(
                          color: Colors.black,
                          width: 2,
                          height: MediaQuery.of(context).size.width * 0.08,
                          radius: const Radius.circular(1),
                          enabled: true,
                        ),
                        keyboardType: TextInputType.phone,
                        onCodeChanged: (code) {
                          if (code?.length == 4) {
                            entered_otp_code = code!;
                          }
                        },
                        decoration: BoxLooseDecoration(
                          strokeColorBuilder: const FixedColorBuilder(
                            Color(0xFFFE9D1D),
                          ),
                          gapSpace: 10,
                        ),
                      ),
                    ),

                    // submit button
                    AccentButton(
                      buttonText: "Submit",
                      onPressed: () {
                        if (entered_otp_code.length != 4) {
                          GlobalData.showOkayDialog(
                            context,
                            "Please enter correct OTP",
                          );
                        } else if (entered_otp_code != verification_code) {
                          GlobalData.showOkayDialog(
                            context,
                            "Please enter correct OTP",
                          );
                        } else {
                          authenticateOTP();
                        }
                      },
                    ),
                    SizedBox(height: (MediaQuery.sizeOf(context).width * 0.04)),
                    //Resend otp
                    ResendOTPView(
                      animation: StepTween(
                        begin: levelClock,
                        end: 0,
                      ).animate(_animationController!),
                      onOTPResend: onOTPResend,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
