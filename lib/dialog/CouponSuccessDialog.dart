import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CouponSuccessDialog extends Dialog {
  const CouponSuccessDialog({super.key});

  static Future<void> showCouponSuccessDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CouponSuccessDialog(),
    );
  }


  @override
  Widget build(BuildContext context) {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  return Dialog.fullscreen(
    backgroundColor: Color(0xFFF6F1F1).withAlpha(200),

    child: InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Center(
        child: Container(
          margin: EdgeInsetsDirectional.symmetric(horizontal: 60),
          width: double.infinity,
          height: 250,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xFF88A54A),width: 2),
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/coupon.gif",
                  height: 150,
                  width: 150,
                ),
                const Text(
                  'Coupon has been\n applied successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "poppins_bold",
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  }
}
