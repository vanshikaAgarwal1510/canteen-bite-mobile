import 'package:canteen_bite_mobile/model/PaymentMethod.dart';
import 'package:canteen_bite_mobile/payment_method/PaymentMethod.dart';
import 'package:canteen_bite_mobile/payment_method/PaymentMethodState.dart';
import 'package:canteen_bite_mobile/utils/view/AccentlButton.dart';
import 'package:canteen_bite_mobile/wallet/Wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../contact/Contact.dart';
import '../../edit_profile/EditProfile.dart';
import '../../help/Help.dart';
import '../../utils/GlobalData.dart';
import 'You.dart';

class YouState extends State<You> {
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
                    setState(() {
                      if (GlobalData.selectedIndexNotifier.value != 0) {
                        GlobalData.selectedIndexNotifier.value = 0;
                      } else {
                        SystemNavigator.pop();
                      }
                    });
                  },
                  child: Icon(Icons.arrow_back_ios, color: Color(0xFFF6F1F1)),
                ),
              ),
            ],
          ),

          Column(
            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFFE9D1D)),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(
                          color: Color(0xFFFE9D1D),
                          width: 1.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: Image.asset("assets/images/avatar.jpg"),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      GlobalData.localDataStore.getNameOfUser() ?? "",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "poppins_semibold",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 15),
                        Text(
                          "+${GlobalData.localDataStore.getUserMobile()}",
                          style: TextStyle(fontSize: 14, fontFamily: "poppins"),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, EditProfile.routeName);
                          },
                          child: Image.asset(
                            "assets/images/icon_edit.png",
                            height: 15,
                            width: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              optionTile(
                icon: "assets/images/icon_wallet.png",
                title: "CampusBite Wallet",
                onTap: () {
                  Navigator.pushNamed(context, Wallet.routeName);
                },
              ),
              optionTile(
                icon: "assets/images/icon_payment.png",
                title: "Payment Methods",
                onTap: () { Navigator.pushNamed(context, PaymentsMethod.routeName);},
              ),
              optionTile(
                icon: "assets/images/icon_contact.png",
                title: "Contact Us",
                onTap: () { Navigator.pushNamed(context, Contact.routeName);},
              ),
              optionTile(
                icon: "assets/images/icon_help.png",
                title: "Help and FAQs",
                onTap: () { Navigator.pushNamed(context, Help.routeName);},
              ),
              SizedBox(height: 100,),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
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

                    },
                    child: Text(
                      "Logout",
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
        ],
      ),
    );
  }

  Widget optionTile({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color:  Color(0xFFFE9D1D)),
        borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ]
      ),
      child: ListTile(
        leading: Image.asset(
          icon,
          height: 30,
          width: 30,
        ),
        title: Text(
          title,
          style: const TextStyle(fontFamily: 'manrope_semibold', fontSize: 15),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
