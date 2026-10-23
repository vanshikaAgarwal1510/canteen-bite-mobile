import 'dart:collection';
import 'dart:convert';

import 'package:canteen_bite_mobile/dialog/ClosedDialog.dart';
import 'package:canteen_bite_mobile/dialog/CouponSuccessDialog.dart';
import 'package:canteen_bite_mobile/dialog/OrderDisabledDialog.dart';
import 'package:canteen_bite_mobile/dialog/OrderExceedDialog.dart';
import 'package:canteen_bite_mobile/model/OrderItems.dart';
import 'package:canteen_bite_mobile/utils/view/AccentlButton.dart';
import 'package:canteen_bite_mobile/utils/view/OrderSummaryCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../../Payment/Payment.dart';
import '../../model/Cart.dart';
import '../../utils/Constants.dart';
import '../../utils/GlobalData.dart';
import '../../utils/ShowErrorException.dart';
import '../../utils/network/NetworkException.dart';
import '../../webservice/ApiCall.dart';
import 'Cart.dart';

class CartState extends State<Cart> {
  final cartModel = GlobalData.cartModel;
  TextEditingController coupon_controller = TextEditingController();
  int order_type = 0;

  List<Map<String, dynamic>> getItems() {
    List<Map<String, dynamic>> list = [];

    for (var item in cartModel.items) {
      list.add({"itemId": item.itemId, "quantity": item.quantity});
    }

    return list;
  }

  Future<void> validateCoupon({bool isRevalidation = false}) async {
    final code = isRevalidation
        ? cartModel.appliedCouponCode
        : coupon_controller.text.trim();

    if (code == null || code.isEmpty) return;

    try {
      Map<String, dynamic> request = HashMap();
      request.addAll({
        "apikey": Constants.apiKey,
        "items": getItems(),
        "couponCode": code,
      });

      ApiCall apiCall = ApiCall();
      dynamic response = await apiCall.validateCoupon(request);
      if (response['status'] == 200) {
        GlobalData.hideProgressDialog(context);
        cartModel.discount = (response['data']['discount'] as num).toDouble();

        cartModel.appliedCouponCode = response['data']['couponCode'];

        cartModel.isCouponApplied = true;

        cartModel.notifyListeners();
        coupon_controller.text == "";
       if(!isRevalidation)CouponSuccessDialog.showCouponSuccessDialog(context);
      } else {
        GlobalData.showSingleActionDialog(
          context,
          response['message'],
          "OK",
          () {
            cartModel.discount = 0.0;
            cartModel.appliedCouponCode = null;
            cartModel.isCouponApplied = false;
            cartModel.notifyListeners();
            coupon_controller.text = "";
            Navigator.pop(context);
          },
        );
      }
    } on NetworkException catch (networkException) {
      if (GlobalData.isProgressDialogShowing)
        GlobalData.hideProgressDialog(context);
      GlobalData.showOkayDialog(context, networkException.toString());
    } on ShowErrorException catch (exception) {
      if (GlobalData.isProgressDialogShowing)
        GlobalData.hideProgressDialog(context);
      GlobalData.showOkayDialog(context, exception.toString());
    } catch (exception) {
      if (GlobalData.isProgressDialogShowing)
        GlobalData.hideProgressDialog(context);
      GlobalData.showOkayDialog(context, exception.toString());
    }
  }

  Future<void> checkOrderAvailable() async {
    try {
      Map<String, dynamic> request = HashMap();
      request.addAll({
        "apikey": Constants.apiKey,
        "items": getItems(),
      });

      ApiCall apiCall = ApiCall();
      dynamic response = await apiCall.checkOrderAvailablity(request);
      if (response['status'] == 200) {
        GlobalData.hideProgressDialog(context);
        Navigator.pushNamed(context, Payment.routeName,);
      } else if(response['status'] == 300){
        ClosedDialog.showClosedDialog(context);
      } else if (response['status'] == 400) {
        OrderDisabledDialog.showOrderDisabledDialog(context);
      }  else if(response['status'] == 500){
        OrderExceedDialog.showOrderExceedDialog(context);
      }else{
        GlobalData.showOkayDialog(context, response['message']);
      }
    } on NetworkException catch (networkException) {
      if (GlobalData.isProgressDialogShowing)
        GlobalData.hideProgressDialog(context);
      GlobalData.showOkayDialog(context, networkException.toString());
    } on ShowErrorException catch (exception) {
      if (GlobalData.isProgressDialogShowing)
        GlobalData.hideProgressDialog(context);
      GlobalData.showOkayDialog(context, exception.toString());
    } catch (exception) {
      if (GlobalData.isProgressDialogShowing)
        GlobalData.hideProgressDialog(context);
      GlobalData.showOkayDialog(context, exception.toString());
    }
  }

  Future<void> showOrderTypeDialog() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog.fullscreen(
          backgroundColor: Color(0xFFF6F1F1).withAlpha(200),

          child: Center(
            child: Container(
              width: double.infinity,
              height: 300,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            cartModel.setOrderType(1);
                            checkOrderAvailable();
                            Navigator.of(dialogContext).pop();

                          },
                          child: Container(
                            height: 106,
                            width: 106,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF779830),width: 2),
                                shape: BoxShape.circle,
                                color: Colors.white
                            ),
                            child: Image.asset("assets/images/illustration10.png"),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Dine-In',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "poppins",
                            color: Colors.black,
                          ),
                        ),

                      ],
                    ),
                    const Text(
                      'OR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "poppins_bold",
                        color: Colors.black,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            cartModel.setOrderType(2);
                            checkOrderAvailable();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Container(
                            height: 106,
                            width: 106,
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF779830),width: 2),
                                shape: BoxShape.circle,
                                color: Colors.white
                            ),
                            child: Image.asset("assets/images/illustration9.png"),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Takeaway',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "poppins",
                            color: Colors.black,
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
      },
    );
  }

  @override
  void initState() {
    super.initState();

    cartModel.onCartChanged = () async {
      await validateCoupon(isRevalidation: true);
    };
  }

  @override
  void dispose() {
    cartModel.onCartChanged = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F1F1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AppBar(
                  title: Text(
                    "Your Cart",
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
            ListenableBuilder(
              listenable: cartModel,
              builder: (context, child) {
                final items = cartModel.items;
                if (cartModel.items.isEmpty){
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 300),
                      child: Column(
                        children: [
                          const Text(
                            'Your Cart is empty',
                            style: TextStyle(
                              fontFamily: "poppins_semibold",
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "+ Add more Items",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "poppins_semibold",
                              color: Color(0xFF779830),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );}
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Container(
                          height: 150,
                          margin: const EdgeInsets.only(
                            left: 18,
                            right: 18,
                            bottom: 15,
                          ),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(9),
                                  child:
                                      item.imageUrl != null &&
                                          item.imageUrl!.isNotEmpty
                                      ? Image.network(
                                          Constants.BASE_URL + item.imageUrl!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Image.asset(
                                            'assets/images/food_placeholder.png',
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Image.asset(
                                          'assets/images/food_placeholder.png',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),

                              const SizedBox(width: 15),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 12,
                                    right: 10,
                                    bottom: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.itemName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'poppins_semibold',
                                          color: Color(0xFF16171B),
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            rating:
                                                (item.averageRating.toDouble())
                                                    .clamp(0.0, 5.0),
                                            itemBuilder: (_, __) => const Icon(
                                              Icons.star,
                                              color: Color(0xFF779830),
                                            ),
                                            itemCount: 5,
                                            itemSize: 18,
                                            direction: Axis.horizontal,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            item.averageRating.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'poppins',
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 4),

                                      Expanded(
                                        child: Text(
                                          item.itemDescription ??
                                              'Delicious food made fresh for you.',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'poppins',
                                          ),
                                        ),
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '₹${item.price}',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'poppins_semibold',
                                              color: Color(0xFF16171B),
                                            ),
                                          ),

                                          // Reactive cart controls
                                          ListenableBuilder(
                                            listenable: cartModel,
                                            builder: (context, child) {
                                              final quantity = cartModel
                                                  .getQuantity(item.itemId);

                                              if (quantity == 0) {
                                                return InkWell(
                                                  onTap: () {
                                                    cartModel.addItem(
                                                      CartItem(
                                                        itemId: item.itemId,
                                                        itemName: item.itemName,
                                                        price: item.price,
                                                        imageUrl: item.imageUrl,
                                                        quantity: 1,
                                                      ),
                                                    );
                                                  },
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Container(
                                                    height: 30,
                                                    width: 85,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                      color: const Color(
                                                        0xFFD9D9D9,
                                                      ),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: const Text(
                                                      'Add',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'poppins_semibold',
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }

                                              return Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  _quantityButton(
                                                    icon: Icons.remove,
                                                    onTap: () {
                                                      cartModel
                                                          .decreaseQuantity(
                                                            item.itemId,
                                                          );
                                                    },
                                                    left: true,
                                                  ),

                                                  Container(
                                                    height: 30,
                                                    width: 32,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: const Color(
                                                          0xFFD9D9D9,
                                                        ),
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                    child: Text(
                                                      '$quantity',
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'poppins_semibold',
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),

                                                  _quantityButton(
                                                    icon: Icons.add,
                                                    onTap: () {
                                                      cartModel
                                                          .increaseQuantity(
                                                            item.itemId,
                                                          );
                                                    },
                                                    left: false,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Text(
                        "+ Add more Items",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "poppins_semibold",
                          color: Color(0xFF779830),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF779830),
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: ListenableBuilder(
                        listenable: cartModel,
                        builder: (context, child) {
                          return OrderSummaryCard(
                            items: cartModel.items,
                            discount: cartModel.discount,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        "Offer/ credit code:",
                        style: TextStyle(
                          fontFamily: "poppins_bold",
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFFCFCFC),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.10,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: coupon_controller,
                                  inputFormatters: [UpperCaseTextFormatter()],
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  cursorColor: const Color(0xFF779830),
                                  style: const TextStyle(
                                    fontFamily: "poppins_semibold",
                                    fontSize: 14,
                                    color: Color(0xFF626176),
                                  ),
                                  decoration: const InputDecoration(
                                    hint: Text(
                                      "Enter offer code",
                                      style: TextStyle(
                                        fontFamily: "poppins_semibold",
                                        fontSize: 14,
                                        color: Color(0xFF626176),
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          ListenableBuilder(
                            listenable: cartModel,
                            builder: (context, child) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (cartModel.isCouponApplied) {
                                    cartModel.discount = 0.0;
                                    cartModel.appliedCouponCode = null;
                                    cartModel.isCouponApplied = false;
                                    cartModel.notifyListeners();

                                    coupon_controller.clear();
                                  } else {
                                    if (coupon_controller.text.trim().isEmpty) {
                                      GlobalData.showOkayDialog(
                                        context,
                                        "Please enter coupon code",
                                      );
                                    } else {
                                      validateCoupon();
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 7,
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color(0xFF779830),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  cartModel.isCouponApplied
                                      ? "Remove"
                                      : "Apply",
                                  style: const TextStyle(
                                    fontFamily: "poppins_semibold",
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
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
                            if (cartModel.orderType == 0){
                              showOrderTypeDialog();
                            }
                            else{
                              checkOrderAvailable();
                            }
                          },
                          child: Text(
                            "Proceed to payment",
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool left,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.horizontal(
            left: left ? const Radius.circular(20) : Radius.zero,
            right: left ? Radius.zero : const Radius.circular(20),
          ),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }





}


class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
      composing: TextRange.empty,
    );
  }
}
