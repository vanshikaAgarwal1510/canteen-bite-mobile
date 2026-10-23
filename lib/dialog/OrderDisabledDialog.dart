import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderDisabledDialog extends Dialog {
  const OrderDisabledDialog({super.key});

  static Future<void> showOrderDisabledDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => OrderDisabledDialog(),
    );
  }


  @override
  Widget build(BuildContext context) {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  return Dialog.fullscreen(
    backgroundColor: Color(0xFFF6F1F1).withAlpha(200),

    child: InkWell(
      onTap: (){Navigator.pop(context);},
      child: Center(
        child: Container(
          width: double.infinity,
          margin: EdgeInsetsGeometry.symmetric(horizontal: 60),
          height: 210,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xFF88A54A),width: 2)
          ),
          child: Stack(
            children: [
              Positioned(
                left: 60,
                right: 60,
                top: 0,
                child: Image.asset(
                  "assets/images/order_disabled.gif",
                  height: 140,
                  width: 140,
                ),
              ),
              Positioned(
                left: 0,
                bottom: 10,
                right: 0,
                child: const Text(
                  'Online ordering is\n currently unavailable.\n Please check back later.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "poppins_semibold",
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }
}
