import 'package:canteen_bite_mobile/utils/view/AccentlButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/GlobalData.dart';
import 'EditProfile.dart';

class EditProfileState extends State<EditProfile> {
  bool isUniversityStudent = true;

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
                  "My Profile",
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
          SizedBox(height: 10),
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(70)),
                  border: Border.all(color: Color(0xFFFE9D1D), width: 1.5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(70)),
                  child: Image.asset("assets/images/avatar.jpg"),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 5,
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFE9D1D),
                  ),
                  child: Icon(Icons.camera, size: 30, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          //   Divider(color: Colors.grey,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 8),
                    Text(
                      "Name",
                      style: TextStyle(fontFamily: "poppins", fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                TextField(
                  // controller: nameController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    prefixStyle: TextStyle(fontFamily: "poppins", fontSize: 17),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFFE9D1D),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                Row(
                  children: [
                    SizedBox(width: 8),
                    Text(
                      "Mobile Number",
                      style: TextStyle(fontFamily: "poppins", fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                TextField(
                  // controller: nameController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    prefixStyle: TextStyle(fontFamily: "poppins", fontSize: 17),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFFE9D1D),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                Row(
                  children: [
                    SizedBox(width: 8),
                    Text(
                      "Email",
                      style: TextStyle(fontFamily: "poppins", fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                TextField(
                  // controller: nameController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    prefixStyle: TextStyle(fontFamily: "poppins", fontSize: 17),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFFE9D1D),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Are you university Student?",
                      style: TextStyle(fontFamily: "poppins", fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    Switch(
                      thumbIcon: WidgetStatePropertyAll(
                        Icon(Icons.circle, color: Color((0xFFEF9D1D))),
                      ),
                      activeThumbColor: Color(0xFFEF9D1D),
                      activeTrackColor: Colors.white,
                      inactiveThumbColor: Color(0xFFEF9D1D),
                      inactiveTrackColor: Colors.white,
                      trackOutlineColor: WidgetStatePropertyAll(
                        Colors.grey.shade300,
                      ),
                      splashRadius: 0,
                      value: isUniversityStudent,
                      onChanged: (value) {
                        setState(() {
                          isUniversityStudent = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          SizedBox(
              height: 50,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
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
                    "Submit",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "poppins_semibold",
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(height: 30,),


        ],
      ),
    );
  }
}
/*
* tanu
* hair spa 4
* hair cut  5
* facial  6
* pedicure 11
*
* vanshika
* facial 7
* full hand wax 8
* half leg wax 9
* pedicure 10
*
* */
