import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:canteen_bite_mobile/Dashboard/cart/Cart.dart';
import 'package:canteen_bite_mobile/model/Cart.dart';
import 'package:canteen_bite_mobile/utils/view/OrderSummaryCard.dart';
import 'package:canteen_bite_mobile/webservice/response/OrderListResponse.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/Order.dart';
import '../../utils/Constants.dart';
import '../../utils/GlobalData.dart';
import '../../utils/ShowErrorException.dart';
import '../../utils/network/NetworkException.dart';
import '../../webservice/ApiCall.dart';
import '../status/Status.dart';
import '../utils/view/Invoice.dart';
import 'OrderDetail.dart';

class OrdersDetailState extends State<OrdersDetail> {
  OrderModel? order;
  bool isExpanded = false;

  Future<void> fetchOrderDetail(int id) async {
    ApiCall apiCall = ApiCall();

    Map<String, dynamic> request = HashMap();
    request.addAll({"apikey": Constants.apiKey, "orderID": id});

    try {
      OrderModel response = await apiCall.fetchOrderDetail(request);
      setState(() {
        order = response;
      });
    } on NetworkException catch (networkException) {
      if (context.mounted) {
        GlobalData.showOkayDialog(context, networkException.toString());
      }
    } on ShowErrorException catch (exception) {
      if (context.mounted) {
        GlobalData.showOkayDialog(context, exception.message!);
      }
    } catch (exception) {
      if (context.mounted) {
        GlobalData.showOkayDialog(context, exception.toString());
      }
    }
  }

  Future<void> fetchInvoice(int id) async {
    ApiCall apiCall = ApiCall();

    Map<String, dynamic> request = HashMap();
    request.addAll({"apikey": Constants.apiKey, "orderID": id});

    try {
      File response = await apiCall.downloadInvoice(request,"Invoice-${order!.id}.pdf");
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => InvoicePreviewScreen(file: response, orderId: order!.id),
        ),
      );
    } on NetworkException catch (networkException) {
      if (context.mounted) {
        GlobalData.showOkayDialog(context, networkException.toString());
      }
    } on ShowErrorException catch (exception) {
      if (context.mounted) {
        GlobalData.showOkayDialog(context, exception.message!);
      }
    } catch (exception) {
      if (context.mounted) {
        GlobalData.showOkayDialog(context, exception.toString());
      }
    }
  }

  Future<void> rateItem(int orderId, int itemId,double stars) async {
    ApiCall apiCall = ApiCall();

    Map<String, dynamic> request = HashMap();
    request.addAll({
      "apikey": Constants.apiKey,
      "orderID": orderId,
      "itemID":itemId,
      "stars":stars
    });

    try {
      dynamic response = await apiCall.rateItem(request);
      if(response['status']==200){
        Fluttertoast.showToast(
          msg: "Item rated successfully.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }else{
        if (context.mounted) {
          GlobalData.showOkayDialog(context, response['message']);
        }
      }
    } on NetworkException catch (networkException) {
      if (context.mounted) {
        GlobalData.showOkayDialog(context, networkException.toString());
      }
    } on ShowErrorException catch (exception) {
      if (context.mounted) {
        GlobalData.showOkayDialog(context, exception.message!);
      }
    } catch (exception) {
      if (context.mounted) {
        GlobalData.showOkayDialog(context, exception.toString());
      }
    }
  }

  getItems() {
    List<CartItem> list = [];
    for (var item in order!.items) {
      list.add(
        CartItem(
          itemId: item.id,
          itemName: item.name,
          price: item.price,
          imageUrl: item.imageUrl,
          quantity: item.quantity,
        ),
      );
    }
    return list;
  }

  void reorder(OrderModel order) {
    final cart = GlobalData.cartModel;
    GlobalData.showDoubleActionDialog(context,
      "Are you sure you want to reorder this order?",
      "Continue", "Cancel",
      () {
        Navigator.pop(context);
        if (cart.items.isNotEmpty) {
          GlobalData.showDoubleActionDialog(context,
            "You have items in your cart.Would you like to replace item or add to existing cart?",
            "Replace", "Add to cart",
            () {cart.clearCart();reorderItem(order);},
            () {reorderItem(order);},
          );
        } else {reorderItem(order);}
      },
      () {
        Navigator.pop(context);
      },
    );
  }
  void reorderItem(OrderModel order) {
    final cart = GlobalData.cartModel;
    for (final item in order.items) {
      cart.addItem(
        CartItem(
          itemId: item.id,
          itemName: item.name,
          price: item.price,
          imageUrl: item.imageUrl,
          quantity: item.quantity,
        ),
      );
    }
    Navigator.pop(context);
    Fluttertoast.showToast(
      msg: "Item added to cart.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 14.0,
    );
    Navigator.pushNamed(context, Cart.routeName);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orderID = ModalRoute.of(context)?.settings.arguments as int;
      fetchOrderDetail(orderID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F1F1),
      body: Column(
        children: [
          //header
          Stack(
            children: [
              AppBar(
                title: Text(
                  "Order detail",
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
          if (order == null)
            Center(child: CircularProgressIndicator(color: Color(0xFFFE9D1D)))
          else
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //order info
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        left: 18,
                        right: 18,
                        bottom: 15,
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFFFCFCFC),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.info, color: Color(0xFFFE9D1D)),
                                  SizedBox(width: 10),
                                  Text(
                                    "Order Information",
                                    style: TextStyle(
                                      fontFamily: "poppins_semibold",
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 25,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFFFE9D1D).withAlpha(40),
                                ),
                                child: Text(
                                  order!.orderType == 1
                                      ? "Dine-in"
                                      : "Takeaway",
                                  style: const TextStyle(
                                    color: Color(0xFFFE9D1D),
                                    fontSize: 12,
                                    fontFamily: "poppins_bold",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(color: Color(0xFFD9D9D9)),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 62,
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFC4C4C4).withAlpha(70),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ORDER ID",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontFamily: 'poppins_semibold',
                                        ),
                                      ),
                                      Text(
                                        "#${order!.id}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black87,
                                          fontFamily: 'poppins_bold',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 62,
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFC4C4C4).withAlpha(70),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "PAYMENT",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontFamily: 'poppins_semibold',
                                        ),
                                      ),
                                      Text(
                                        order!.paymentStatus,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'poppins_bold',
                                          color:
                                              order!.paymentStatus
                                                      .toLowerCase() ==
                                                  "pending"
                                              ? Color(0xFFFE9D1D)
                                              : Color(0xFF779830),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 62,
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFC4C4C4).withAlpha(70),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ORDER DATE AND TIME",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                    fontFamily: 'poppins_semibold',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      GlobalData.convertToLocalDate(
                                        order!.orderDate.toString(),
                                      ),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black87,
                                        fontFamily: 'poppins_bold',
                                      ),
                                    ),
                                    Text(
                                      ", ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black87,
                                        fontFamily: 'poppins_bold',
                                      ),
                                    ),

                                    Text(
                                      GlobalData.convertToLocalTime(
                                        order!.orderDate.toString(),
                                      ),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black87,
                                        fontFamily: 'poppins_bold',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          (order!.requirePickupCode && order!.status!=4)?SizedBox(height: 20):SizedBox(),
                          (order!.requirePickupCode && order!.status!=4)?
                          DottedBorder(
                            options: RoundedRectDottedBorderOptions(
                              color: Color(0xFFFE9D1D),
                              strokeWidth: 2,
                              dashPattern: [7, 4],
                              radius: Radius.circular(15),
                            ),
                            child: Container(
                              height: 80,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFFE9D1D).withAlpha(30),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "PICKUP CODE",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontFamily: 'poppins_semibold',
                                        ),
                                      ),
                                      Text(
                                        order!.pickupCode!,
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black87,
                                          fontFamily: 'poppins_bold',
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await Clipboard.setData(
                                        ClipboardData(
                                          text: order!.pickupCode!.toString(),
                                        ),
                                      );

                                      Fluttertoast.showToast(
                                        msg: "Copied to clipboard.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.black87,
                                        textColor: Colors.white,
                                        fontSize: 14.0,
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 7,
                                        vertical: 7,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFE9D1D),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.copy,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Copy",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                              fontFamily: 'poppins_bold',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ):SizedBox(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Status.routeName,
                                arguments: order!.status,
                              );
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFFEDF6DC),
                                border: Border.all(color: Color(0xFF5C6139)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.track_changes,
                                    color: Color(0xFF5C6139),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Track order",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Color(0xFF5C6139),
                                      fontFamily: 'poppins_bold',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),

                    //order items
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          left: 18,
                          right: 18,
                          bottom: 15,
                        ),
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 15,
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
                          children: [
                            Text(
                              'Order Items',
                              style: TextStyle(
                                fontFamily: "poppins_semibold",
                                fontSize: 18,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: (isExpanded)
                          ? ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: order!.items.length,
                              itemBuilder: (context, index) {
                                final item = order!.items[index];

                                return Container(
                                  height: 120,
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 15),
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
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        height: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child:
                                              item.imageUrl != null &&
                                                  item.imageUrl!.isNotEmpty
                                              ? Image.network(
                                                  Constants.BASE_URL +
                                                      item.imageUrl!,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) =>
                                                      Image.asset(
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    item.name,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'poppins_semibold',
                                                      color: Color(0xFF16171B),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 25,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 2,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFEDF6DC),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                            Radius.circular(7),
                                                          ),
                                                    ),
                                                    child: Text(
                                                      "Qty:${item.quantity}",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Color(
                                                          0xFF5C6139,
                                                        ),
                                                        fontFamily:
                                                            'poppins_bold',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(height: 4),

                                              Row(
                                                children: [
                                            //  double rating = 0;

                                              RatingBar.builder(
                                                initialRating: (item.averageRating.toDouble()).clamp(0.0, 5.0) ,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 18,
                                                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                                                itemBuilder: (context, index) => const Icon(
                                                  Icons.star,
                                                  color: Color(0xFF779830,),
                                                ),
                                                onRatingUpdate: (value) {
                                                  rateItem(order!.id,item.id,value);
                                                  print('Selected rating: $value');
                                                },
                                              ),

                                                  const SizedBox(width: 5),
                                                  Text(
                                                    "Rate this item",
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'poppins',
                                                      color:  Color(0xFF779830,),
                                                      decoration: TextDecoration.underline,
                                                      decorationColor:Color(0xFF779830,),

                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(height: 4),

                                              Expanded(
                                                child: Text(
                                                  'Delicious food made fresh for you.',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'poppins',
                                                  ),
                                                ),
                                              ),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '₹${item.price}',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'poppins_bold',
                                                          color: Color(
                                                            0xFF16171B,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        ' x ${item.quantity}',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'poppins_semibold',
                                                          color: Colors
                                                              .grey
                                                              .shade700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '₹${item.price * item.quantity}',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'poppins_bold',
                                                      color: Color(0xFF16171B),
                                                    ),
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
                            )
                          : SizedBox(),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: OrderSummaryCard(items: getItems()),
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: (){fetchInvoice(order!.id);},
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 20, left: 18),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFCFCFC),
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.receipt_long),
                                  SizedBox(width: 8),
                                  Text(
                                    "Download invoice",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'poppins_bold',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {reorder(order!);},
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                top: 20,
                                right: 18,
                                left: 10,
                              ),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFCFCFC),
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/icon_reorder.png"),
                                  SizedBox(width: 8),
                                  Text(
                                    "Reorder items",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'poppins_semibold',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
