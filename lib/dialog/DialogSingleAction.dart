import 'package:flutter/material.dart';

class DialogSingleAction extends Dialog {
  final String title; // Dialog title
  final String message; // Dialog content
  final String buttonText; // Button text
  final VoidCallback onPressed; // Button action callback

  const DialogSingleAction({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      child: SizedBox(
        width: (MediaQuery.sizeOf(context).width > 620) ? 400 : MediaQuery.sizeOf(context).width - 100,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF6F7F9),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "poppins_bold",
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  message,
                  style: const TextStyle(
                    fontFamily: "poppins",
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ButtonStyle(
                      //fixedSize: WidgetStateProperty.all<Size>(Size.fromHeight(50)),
                      minimumSize: WidgetStateProperty.all(const Size(120, 50)),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color(0xFFFE9D1D),
                      ),
                      foregroundColor: WidgetStateProperty.all<Color>(
                        Colors.white,
                      ),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      textStyle: WidgetStateProperty.all<TextStyle>(
                        const TextStyle(fontSize: 18),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontFamily: "poppins_bold",
                        fontSize: 18.0, // Set font size
                        color: Colors.white, // Set font color
                      ),
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
