
import 'dart:convert';
import 'package:flutter/material.dart';
import 'Home.dart';

class HomeState extends State<Home> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              height: 330,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/food_doodle.png'),
                 fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                    Colors.white.withValues(alpha: 0.4),
                    BlendMode.srcIn,
                  )
                ),
                color: Color(0xFFFE9D1D),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(35), bottomLeft: Radius.circular(35))
             ,boxShadow: [BoxShadow(
                  color: Colors.black54,
              blurRadius: 10),
              ]
              ),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.paddingOf(context).top,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Home",style: TextStyle(
                          fontSize: 25,
                          fontFamily: "poppins_bold",
                          color: Colors.white
                        ),),
                       Stack(
                         children: [
                           Image.asset('assets/images/icon_notification.png',height: 25,),
                           Positioned(
                             right: 2,
                             top: 4,
                             child: Container(
                               height: 6,width: 6,decoration: BoxDecoration(
                               shape: BoxShape.circle,color: Color(0xFFDB3F40)
                             ),
                             ),
                           )
                         ],
                       )
                      ],
                    ),
                  ),
                 SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 7), // shadow position
                        ),
                      ],
                    ),
                    child: TextField(
                      cursorColor: Color(0xFFFE9D1D),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "poppins_semibold",
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search_sharp, size: 30),
                        hintText: "Search dish",
                        hintStyle: TextStyle(
                          fontSize: 17,
                          color: Color(0xFFC4C4C4),
                          fontFamily: "poppins_semibold",
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
      Expanded(
        child: PageView(
          controller: controller,
          children: [
            sliderCard(
              "ORDER WITHIN SECONDS VIA",
              "UPI PAYMENT",
              "Choose your favorite item and complete the order within seconds",
              'assets/images/illustrator4.png',
              'assets/images/illustrator3.png'
            ),
            sliderCard(
              "WELCOME OFFER",
              "₹50 OFF ON FIRST ORDER",
              "New here? Get ₹50 off on your first order and enjoy. Use Code WELCOME50",
                'assets/images/illustrator5.png',
                'assets/images/illustrator1.png'),
            sliderCard(
              "SPECIAL OFFER FOR",
              "UNIVERSITY STUDENTS",
              "Save 10 % on every order, valid only for campus students. Use Code SAVE10",
                'assets/images/illustrator7.png',
                'assets/images/illustrator6.png'),

          ],
        ),
      )
                ],
              ),
            )
          ],
        ),
      )
     );

  }

  Widget sliderCard(String title,
      String subtitle, String description,
      String imgUrl1, String imgUrl2) {
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: "patrick",
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: "patrick",
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "poppins",
                    fontSize: 13,
                  ),
                ),
                ElevatedButton(onPressed: (){}, child: Text("Choose"))
              ],
            ),
          ),
          Positioned(
              right:-25,
              top: 0,
              child: Image.asset(imgUrl1),height: 111,),
          Positioned(
            left:-10,
            bottom: 0,
            child: Image.asset(imgUrl2),height: 115,)
        ],
      ),
    );
  }
}
