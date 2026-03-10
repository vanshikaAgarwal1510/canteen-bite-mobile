import 'package:flutter/material.dart';

class DialogDoubleAction extends Dialog {
  final String title; // Dialog title
  final String message; // Dialog content
  final String buttonTextLeft;
  final String buttonTextRight;// Button text
  final VoidCallback onPressedLeft;
  final VoidCallback onPressedRight;// Button action callback

  const DialogDoubleAction({
    super.key,
    required this.title,
    required this.message,
    required this.buttonTextLeft,
    required this.buttonTextRight,
    required this.onPressedLeft,
    required this.onPressedRight,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      child: SizedBox(
        width: (MediaQuery.sizeOf(context).width > 620) ? 350 : MediaQuery.sizeOf(context).width - 150,
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
                    fontFamily: "poppins_semibold",
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
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: onPressedLeft,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side: const BorderSide(color: Color(0xFFFE9D1D), width: 1.0,),
                          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                          minimumSize: Size(100, 50),
                          textStyle: TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                        ),
                        child: Text(
                          buttonTextLeft,
                          style: TextStyle(
                            fontFamily: "poppins_bold",
                            fontSize: 18.0, // Set font size
                            color: Color(0xFF2D2D2D), // Set font color
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height < 700 ? 15 : 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: onPressedRight,
                        style: ButtonStyle(
                          //fixedSize: WidgetStateProperty.all<Size>(Size.fromHeight(50)),
                          minimumSize: WidgetStateProperty.all(const Size(100, 50)),
                          backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFFFE9D1D)),
                          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.fromLTRB(25, 10, 25, 10)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                          textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(fontSize: 18)),
                        ),
                        child: Text(
                          buttonTextRight,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
