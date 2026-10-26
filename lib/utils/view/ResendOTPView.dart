import 'package:flutter/cupertino.dart';


class ResendOTPView extends AnimatedWidget {

  Animation<int> animation;
  final Function() onOTPResend;

  ResendOTPView(
      {
        Key? key,
        required this.animation,
        required this.onOTPResend
      }
      ) : super(key: key, listenable: animation);

  @override
  build(BuildContext context) {

    Duration clockTimer = Duration(seconds: animation.value);
    String timerText = '00:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return  GestureDetector(
        onTap: () {
          // Handle the tap event here
          if (timerText == "00:00") {
            onOTPResend();
          }
        },
        child: Text(
          (timerText == "00:00")
              ? "Resend OTP now"
              : "Resend OTP in "+timerText ,
          //"Resend OTP in ",
          style: TextStyle(
            fontFamily: "Rethink_semibold",
            fontSize: 25 / MediaQuery.of(context).devicePixelRatio, // Set font size
            color: Color(0xFFFE9D1D), // Set font color
          ),
        )
    );
  }

}