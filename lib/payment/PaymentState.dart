
import 'dart:collection';

import 'package:canteen_bite_mobile/model/PaymentMethod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/Constants.dart';
import '../../utils/GlobalData.dart';
import '../../utils/ShowErrorException.dart';
import '../../utils/network/NetworkException.dart';
import '../../webservice/ApiCall.dart';
import '../../webservice/response/PaymentMethodResponse.dart';
import 'Payment.dart';

class PaymentState extends State<Payment> {
  PaymentMethod? selectedPaymentMethod;
  final cartModel = GlobalData.cartModel;
  List<PaymentMethod>? list_payment;
  double total_amount = 0;


  List<Map<String, dynamic>> getItems() {
    List<Map<String, dynamic>> list = [];

    for (var item in cartModel.items) {
      list.add({"itemId": item.itemId, "quantity": item.quantity});
    }

    return list;
  }

  Future<void> fetchDetails() async
  {
    try {
      Map<String, dynamic> request = HashMap();
      request.addAll({
        "apikey": Constants.apiKey,
      });

      ApiCall apiCall = ApiCall();
      PaymentMethodResponse response = await apiCall.fetchPaymentMethod(
          request);
      if (response.status == 200) {
        GlobalData.hideProgressDialog(context);
        setState(() {
          list_payment = response.data;
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

  Future<void> showOrderSuccessDialog() async {
    await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {

        return Dialog.fullscreen(
          backgroundColor: Color(0xFFF6F1F1).withAlpha(200),

          child: InkWell(
            onTap: (){
              Navigator.of(dialogContext).pop();
            },
            child: Center(
              child: Container(
                width: double.infinity,
                height: 300,
               padding: EdgeInsets.all(0),
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Container(
                           height: 70,
                           width: 70,
                           decoration: const BoxDecoration(
                             color: Color(0xFF779830),
                             shape: BoxShape.circle,
                           ),
                           child: const Icon(
                             Icons.check,
                             color: Colors.white,
                             size: 55,
                           ),
                         ),
                         const SizedBox(height: 20),
                         const Text(
                           'Your order has\nbeen placed!',
                           textAlign: TextAlign.center,
                           style: TextStyle(
                             fontSize: 20,
                             fontFamily: "poppins_bold",
                             color: Colors.black,
                           ),
                         ),


                       ],
                                          ),
                    ),
                    Positioned(
                        bottom: 80,
                        right: -30,
                        child: Image.asset("assets/images/icon_confetti1.gif",height:230,width: 310,)),
                    Positioned(
                        bottom: 80,
                        left: -30,
                        child: Image.asset("assets/images/icon_confetti_reverse.gif",height:230,width: 310,))

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> placeOrder() async
  {
    try {
      Map<String, dynamic> request = HashMap();
      request.addAll({
        "apikey": Constants.apiKey,
        "items": getItems(),
        "paymentMethod": selectedPaymentMethod!.id,
        "orderType": cartModel.orderType,
      });
      request.addIf(cartModel.appliedCouponCode != null, "couponCode", cartModel.appliedCouponCode);
      ApiCall apiCall = ApiCall();
      dynamic response = await apiCall.placeOrder(
          request);
      if (response['status'] == 200) {
        GlobalData.hideProgressDialog(context);
        showOrderSuccessDialog();
        cartModel.clearCart();


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
      fetchDetails();
      if (!mounted) return;

      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg is double) {
        setState(() {
          total_amount = arg;
        });
      }
    });
    super.initState();
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
                  "payment",
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
          Container(
            height: 75,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 18, right: 18, bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFFCFCFC),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total amount payable:",
                  style: TextStyle(fontSize: 20, fontFamily: "poppins_bold",color: Color(0xFFFE9D1D)),
                ),
                Text(
                  "₹${GlobalData.cartModel.total.toString()}",
                  style: TextStyle(fontSize: 20, fontFamily: "poppins_bold",color: Color(0xFFFE9D1D)),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(
              color: Colors.black54,
              thickness: 1,
              radius: BorderRadius.all(Radius.circular(10))
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text("Select payment method",style: TextStyle( fontFamily: "poppins_semibold",fontSize: 18),),
          ),
          SizedBox(height: 10,),
          list_payment!=null?Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 0),
              physics: const BouncingScrollPhysics(),
              itemCount: list_payment!.length,
              itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedPaymentMethod = list_payment![index];
                });
              },
              child: Container(
                height: 90,
                width: double.infinity,
                margin: const EdgeInsets.only(
                  left: 18,
                  right: 18,
                  bottom: 15,
                ),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFFCFCFC),
                  border: Border.all(
                    color: selectedPaymentMethod == list_payment![index]
                        ? const Color(0xFFFE9D1D)
                        : Colors.transparent,
                    width: 1.5,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    (list_payment![index].imageUrl != null &&
                        list_payment![index].imageUrl!.isNotEmpty)
                        ? SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(
                        Constants.BASE_URL + list_payment![index].imageUrl!,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'assets/images/food_placeholder.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                        : SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(
                        'assets/images/money.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            list_payment![index].name,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "poppins_semibold",
                            ),
                          ),
                          Text(
                            list_payment![index].description,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "poppins",
                            ),
                      ),
                    ]),),
                   /* if (selectedPaymentMethod == "counter")
                      const Ic
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],on(
                        Icons.check_circle,
                        color: Color(0xFFFE9D1D),
                      ),*/
                  ],
                ),
              ),
            );}
            )
          ): Center(child: Column(
            children: [
              SizedBox(height: 100,),
              CircularProgressIndicator(color: Color(0xFFFE9D1D),),
              SizedBox(height: 100,),
             ],
          )),
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
                  if(selectedPaymentMethod ==null){
                    GlobalData.showOkayDialog(context, "Please select a payment method");
                  }else{placeOrder();}
                      },
                child: Text(
                  "Make payment",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "poppins_semibold",
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
