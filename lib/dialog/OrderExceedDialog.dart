import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderExceedDialog extends Dialog {
  const OrderExceedDialog({super.key});

  static Future<void> showOrderExceedDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => OrderExceedDialog(),
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
                top: 5,
                child: Image.asset(
                  "assets/images/people1.gif",
                  height: 150,
                  width: 150,
                ),
              ),
              Positioned(
                left: 0,
                bottom: 20,
                right: 0,
                child: const Text(
                  'The crowd traffic at \ncafeteria is very High!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
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
