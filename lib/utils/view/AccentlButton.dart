import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccentButton extends StatelessWidget {

  final String buttonText;
  final Function() onPressed;
  Color? backgroundColor = null;
  double? fontSize = null;

  AccentButton(
      {
        super.key,
        required this.buttonText,
        required this.onPressed,
        this.backgroundColor,
        this.fontSize
      }
  );

  @override
  build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(7),
          backgroundColor: WidgetStateProperty.all<Color>(
            (backgroundColor != null) ? backgroundColor! : Color(0xFFFE9D1D),
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            Colors.white,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          textStyle: WidgetStateProperty.all<TextStyle>(
            const TextStyle(fontSize: 18),
          ),
          minimumSize: WidgetStateProperty.all(const Size(double.infinity, 58)),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontFamily: "poppins_semibold",
            fontSize: (fontSize != null) ? fontSize! : 20, // Set font size
            color: Colors.white, // Set font color
          ),
        ),
      ),
    );
  }

}