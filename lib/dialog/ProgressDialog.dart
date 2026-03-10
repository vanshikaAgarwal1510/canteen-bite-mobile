import 'package:flutter/material.dart';


class ProgressDialog extends Dialog {
  final bool isDarkTheme; // Dialog title

  const ProgressDialog({
    super.key,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        // Handle back navigation
        /*setState(() {
          if(GlobalData.selectedIndexNotifier.value != 0){
            onPageSelected(0);
          } else {
            SystemNavigator.pop();
          }
        });*/
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 10,
        child: SizedBox(
          width: 150,
          child: Container(
            height: 140,
            decoration: BoxDecoration(
              color: isDarkTheme ? Color(0xFF2D2D2D) : Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CircularProgressIndicator(
                          color: Color(0xFFFE9D1D),
                        ),
                      )
                  ),
                  //SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "LOADING...\nPLEASE WAIT",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "poppins",
                        fontSize: 14,
                        color: isDarkTheme ? Color(0xFFFFFFFF) : Color(0xFF2D2D2D),
                      ),
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
