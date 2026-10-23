import 'dart:collection';
import 'dart:convert';

import 'package:canteen_bite_mobile/webservice/response/OrderListResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../model/Order.dart';
import '../../order_detail/OrderDetail.dart';
import '../../utils/Constants.dart';
import '../../utils/GlobalData.dart';
import '../../utils/ShowErrorException.dart';
import '../../utils/network/NetworkException.dart';
import '../../webservice/ApiCall.dart';
import 'Orders.dart';

class OrdersState extends State<Orders> {
  List<OrderModel> order_list = [];

  Future<void> fetchOrders() async {
    ApiCall apiCall = ApiCall();

    Map<String, dynamic> request = HashMap();
    request.addAll({"apikey": Constants.apiKey});

    try {
      OrderListResponse response = await apiCall.fetchOrderList(request);
      setState(() {
        order_list = response.orders;
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

  getRating(OrderModel order) {
    int sum = 0;
    for (var item in order.items) {
      sum += item.averageRating;
    }
    return sum / order.items.length;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchOrders();
    });
  }

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
                  "Food orders",
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
          (order_list.isEmpty)
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 300),
                    child: Column(
                      children: [
                        const Text(
                          'No orders yet!',
                          style: TextStyle(
                            fontFamily: "poppins_semibold",
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Order now",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "poppins_semibold",
                            color: Color(0xFF779830),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: order_list.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsetsGeometry.fromLTRB(15, 0, 15, 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                buildOrderGrid(order_list[index]),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Order #${order_list[index].id}",
                                        style: TextStyle(
                                          fontFamily: "poppins_semibold",
                                          fontSize: 18,
                                          color: Color(0xFF16171B),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RatingBarIndicator(
                                            rating: (getRating(
                                              order_list[index],
                                            )).clamp(0.0, 5.0),
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
                                            "(${getRating(order_list[index]).toString()})",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Order Date & Time",
                                        style: TextStyle(
                                          fontFamily: "poppins_semibold",
                                          fontSize: 14,
                                        ),
                                      ),
                                       Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              GlobalData.convertToLocalDate(
                                                order_list[index].orderDate
                                                    .toString(),
                                              ),
                                              style: TextStyle(
                                                fontFamily: "poppins",
                                                fontSize: 13,
                                              ),
                                            ),
                                            SizedBox(width: 20,),
                                            Text(
                                              GlobalData.convertToLocalTime(
                                                order_list[index].orderDate
                                                    .toString(),
                                              ),
                                              style: TextStyle(
                                                fontFamily: "poppins",
                                                fontSize: 13,
                                              ),
                                            ),

                                          ],
                                        ),

                                      const SizedBox(height: 5),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Amount",
                                                style: TextStyle(
                                                  fontFamily:
                                                      "poppins_semibold",
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                "₹${order_list[index].totalAmount}",
                                                style: TextStyle(
                                                  fontFamily: "poppins",
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 38),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Order Type",
                                                style: TextStyle(
                                                  fontFamily:
                                                      "poppins_semibold",
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                order_list[index].orderType == 1
                                                    ? "Dine-in"
                                                    : "Takeaway",
                                                style: TextStyle(
                                                  fontFamily: "poppins",
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(color: Color(0xFFC4C4C4), thickness: 1),

                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {Navigator.pushNamed(context, OrdersDetail.routeName,arguments: order_list[index].id);},
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        Image.asset("assets/images/icon_detail.png"),
                                        const SizedBox(width: 5),
                                        const Text(
                                          "Order Detail",
                                          style: TextStyle(
                                            fontFamily: "poppins_semibold",
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      print("reorder clicked");
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset("assets/images/icon_reorder.png"),
                                        const SizedBox(width: 7),
                                        const Text(
                                          "Reorder",
                                          style: TextStyle(
                                            fontFamily: "poppins_semibold",
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildOrderGrid(OrderModel order) {
    final items = order.items.take(4).toList();

    return Container(
      width: 150,
      height: 144,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFD9D9D9),
      ),

      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: items.length == 1 ? 1 : 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFFCFCFC),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  items[index].imageUrl != null &&
                      items[index].imageUrl!.isNotEmpty
                  ? Image.network(
                      Constants.BASE_URL + items[index].imageUrl!,
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
          );
        },
      ),
    );
  }
}
