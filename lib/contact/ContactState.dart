import 'package:canteen_bite_mobile/utils/view/AccentlButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/GlobalData.dart';
import 'Contact.dart';

class ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F1F1),

      body: Column(
        children: [
          Stack(
            children: [
              AppBar(
                title: Text(
                  "Contact Us",
                  style: TextStyle(
                    fontFamily: "poppins_bold",
                    color: Color(0xFFF6F1F1),
                  ),
                ),
                backgroundColor: Color(0xFFFE9D1D),
                leading: SizedBox(),
              ),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/food_doodle.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withValues(alpha: 0.4),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios, color: Color(0xFFF6F1F1)),
                ),
              ),
            ],
          ),
          Image.asset("assets/images/contact_banner.png"),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(width: 20,),
                Container(
                  width: 80,
                  height:80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFE9D1D).withAlpha(50),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 55,
                    height:55,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFE9D1D),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/icon_contact.png",
                      width: 25,
                      height: 25,
                      color: Colors.white,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Call Us", style: TextStyle(
                      fontFamily: "poppins_bold",
                      fontSize: 20,
                      color: Colors.black,
                    )),
                    Text("+91 98765432100", style: TextStyle(
                      fontFamily: "poppins_semibold",
                      fontSize: 14,
                      color: Colors.grey
                    )),
                    Text("Call us for quick support.", style: TextStyle(
                      fontFamily: "poppins",
                      fontSize: 13,
                      color: Colors.grey,
                    )),
                  ],

                ),
                Spacer(),
                Container(
                  width: 35,
                  height:35,
                  decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFE9D1D).withAlpha(50),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.arrow_forward_ios,color: Color(0xFFFE9D1D),size: 18,)
                ),
                SizedBox(width: 20,),
              ],
            ),
            ),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(width: 20,),
                Container(
                  width: 80,
                  height:80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF779830).withAlpha(50),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 55,
                    height:55,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF779830),
                    ),
                    alignment: Alignment.center,
                    child:Icon(Icons.email,color: Colors.white,size: 25)
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email Us",
                        style: TextStyle(
                          fontFamily: "poppins_bold",
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "support@campusbite.in",
                        style: TextStyle(
                          fontFamily: "poppins_semibold",
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "We usually respond within 24 hours.",
                        style: TextStyle(
                          fontFamily: "poppins",
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
                Container(
                    width: 35,
                    height:35,
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF779830).withAlpha(50),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.arrow_forward_ios,color: Color(0xFF779830),size: 18,)
                ),
                SizedBox(width: 20,),
              ],
            ),
          ),



        ],
      ),
    );
  }
}
