import 'package:canteen_bite_mobile/utils/view/AccentlButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/GlobalData.dart';
import 'Status.dart';

class StatusState extends State<Status> {
  int status=0;
  final steps = const [
    ("Order Placed", "assets/images/order_pending.png"),
    ("Order Preparing", "assets/images/order_preparing.png"),
    ("Order Ready", "assets/images/order_ready.png"),
    ("Order Completed", "assets/images/order_completed.png"),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg is int) {
        setState(() {
          status = arg;
        });
        print(status);
      }
    });
  }

  String getSubtitle(){
    switch(status){
      case 0:
        return "";
      case 1:
        return "Your order has been placed.Your order will be prepared soon.";
      case 2:
       return "Your food is being prepared. Order will be ready in next 10-15 minutes.";
      case 3:
        return "Your order is ready.You can collect your order from the canteen.";
      case 4:
        return "Your order has been completed.Thank you for using CampusBite.";
      default:
        return "Your order has been placed.";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F1F1),

      body: Column(
        children: [
          SizedBox(height: 30,),
          Center(child: Image.asset("assets/images/status_header.png",height: 150,)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              getSubtitle(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontFamily: "poppins",
              ),
              maxLines: 2,
            ),
          ),
          SizedBox(height: 30,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               SizedBox(
                   height: 400,
                   child: _stepperVertical(headerTitle: "abc")),
               Column(
                 children: [
                   Row(
                     children: [
                       Stack(
                         children: [
                           Positioned(
                           left: 0,
                           right: 0,
                           top: 20,
                           bottom: 20,
                           child: Container(
                             height: 35,
                             width: 35,
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               color: status>=1
                                   ? const Color(0xFF779830)
                                   : Color(0xFFC4C4C4),
                             ),
                           ),
                         ),
                           Image.asset(steps[0].$2,height: 70,width: 70,),

                         ],
                       ),
                       SizedBox(width: 20,),
                       Text(
                         steps[0].$1,
                         style: TextStyle(
                           fontSize: 15,
                           fontFamily: "poppins_semibold",
                         ),
                       ),
                     ],
                   ),
                   SizedBox(height: 50,),
                   Row(
                     children: [
                       Stack(
                         children: [
                           Positioned(
                             left: 0,
                             right: 0,
                             top: 10,
                             bottom: 30,
                             child: Container(
                               height: 35,
                               width: 35,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: status>=2
                                     ? const Color(0xFF779830)
                                     : Color(0xFFC4C4C4),
                               ),
                             ),
                           ),
                           Image.asset(steps[1].$2,height: 70,width: 70,),

                         ],
                       ),
                       SizedBox(width: 20,),
                       Text(
                         steps[1].$1,
                         style: TextStyle(
                           fontSize: 15,
                           fontFamily: "poppins_semibold",
                         ),
                       ),
                     ],
                   ),
                   SizedBox(height: 50,),
                   Row(
                     children: [
                       Stack(
                         children: [
                           Positioned(
                             left: 0,
                             right: 5,
                             top: 20,
                             bottom: 20,
                             child: Container(
                               height: 35,
                               width: 35,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: status>=3
                                     ? const Color(0xFF779830)
                                     : Color(0xFFC4C4C4),
                               ),
                             ),
                           ),
                           Image.asset(steps[2].$2,height: 70,width: 70,),

                         ],
                       ),
                       SizedBox(width: 20,),
                       Text(
                         steps[2].$1,
                         style: TextStyle(
                           fontSize: 15,
                           fontFamily: "poppins_semibold",
                         ),
                       ),
                     ],
                   ),
                   SizedBox(height: 50,),
                   Row(
                     children: [
                       Stack(
                         children: [
                           Positioned(
                             left: 25,
                             right: 0,
                             top: 30,
                             bottom: 25,
                             child: Container(
                               height: 35,
                               width: 35,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: status>=4
                                     ? const Color(0xFF779830)
                                     : Color(0xFFC4C4C4),
                               ),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 30.0,bottom: 25),
                             child: Image.asset(steps[3].$2,height: 65,width: 65,),
                           ),

                         ],
                       ),
                       SizedBox(width: 20,),
                       Text(
                         steps[3].$1,
                         style: TextStyle(
                           fontSize: 15,
                           fontFamily: "poppins_semibold",
                         ),
                       ),
                     ],
                   ),

                 ]
               )
             ],
           ),
          SizedBox(height: 50,),
          SizedBox(
            height: 50,
            width: 180,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Color(0xFF16171B),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "poppins_semibold",
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
  Widget _stepperVertical({required String headerTitle})  {
    const double iconSize = 12;

    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              for (int i = 0; i < steps.length; i++) ...[
                if (i > 0)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: i < status
                          ? const Color(0xFF779830)
                          : Colors.black,
                    ),
                  ),
                Container(
                  height: iconSize,
                  width: iconSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i < status
                        ? const Color(0xFF779830)
                        : Colors.black,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }}
