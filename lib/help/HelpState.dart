import 'dart:collection';

import 'package:canteen_bite_mobile/utils/view/AccentlButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/GlobalData.dart';
import '../model/Faq.dart';
import '../utils/Constants.dart';
import '../utils/ShowErrorException.dart';
import '../utils/network/NetworkException.dart';
import '../webservice/ApiCall.dart';
import 'Help.dart';

class HelpState extends State<Help>{
 List<Faq> faqs = [];


  Future<void> fetchFaq() async
  {
    try {
      Map<String, dynamic> request = HashMap();
      request.addAll({
        "apikey": Constants.apiKey,
      });

      ApiCall apiCall = ApiCall();
      dynamic response = await apiCall.fetchFAQ(request);
      if (response['status'] == 200) {
        GlobalData.hideProgressDialog(context);
        setState(() {
          faqs = (response['data'] as List).map((e) => Faq.fromJson(e))
              .toList();
        });
      }
      else {
        GlobalData.showOkayDialog(context, response.message);
      }
    } on NetworkException catch (networkException) {
      if (GlobalData.isProgressDialogShowing) GlobalData.hideProgressDialog(
          context);
      GlobalData.showOkayDialog(context, networkException.toString());
    } on ShowErrorException catch (exception) {
      if (GlobalData.isProgressDialogShowing) GlobalData.hideProgressDialog(
          context);
      GlobalData.showOkayDialog(context, exception.toString());
    } catch (exception) {
      if (GlobalData.isProgressDialogShowing) GlobalData.hideProgressDialog(
          context);
      GlobalData.showOkayDialog(context, exception.toString());
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchFaq();
    super.initState();
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F1F1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AppBar(
                title: Text(
                  "Help and FAQs",
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
          Image.asset("assets/images/faq_banner1.png"),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text("Popular Question",style: TextStyle(
              fontFamily: "poppins_bold",
              fontSize: 20,
              color: Colors.black,
            ),),
          ),
          
          faqs.isEmpty?
              Expanded(child: Center(child: CircularProgressIndicator(color: Color(0xFFFE9D1D),)))
          :
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 10),
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              final faq = faqs[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12,left: 18,right: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(30),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    childrenPadding: const EdgeInsets.fromLTRB(
                      16, 0, 16, 16,
                    ),
                    leading: const Icon(
                      Icons.help_outline_rounded,
                      color: Color(0xFFFE9D1D),
                    ),
                    title: Text(
                      faq.question,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "poppins_semibold",
                        color: Colors.black87,
                      ),
                    ),
                    iconColor: const Color(0xFFFE9D1D),
                    collapsedIconColor: Colors.grey,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          faq.answer,
                          style: const TextStyle(
                            fontSize: 13,
                            fontFamily: "poppins",
                            letterSpacing: 0.5,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )

        ],
      ),
    );
  }


}
