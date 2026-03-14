
import 'package:canteen_bite_mobile/Dashboard/you/You.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../profile/Profile.dart';
import '../utils/GlobalData.dart';
import 'Dashboard.dart';
import 'Home/Home.dart';

import 'cart/Cart.dart';
import 'orders/Orders.dart';

class DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  late PersistentTabController controller_bottom_tab;
  late TabController _tabController;

  static Home homePage = const Home();
  static Cart cartPage = const Cart();
  static Orders ordersPage = const Orders();
  static You profilePage = const You();

  final List<Widget> _pages = [
    homePage,
    cartPage,
    ordersPage,
    profilePage,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    GlobalData.selectedIndexNotifier.addListener(() {
      if (_tabController.index != GlobalData.selectedIndexNotifier.value) {
        _tabController.animateTo(GlobalData.selectedIndexNotifier.value);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //loadInitialData(context);
    });
  }

  void onPageSelected(int index) {
    setState(() {
      GlobalData.selectedIndexNotifier.value = index;
      if (GlobalData.selectedIndexNotifier.value == 2) {
        //Search
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        // Handle back navigation
        setState(() {
          if (GlobalData.selectedIndexNotifier.value != 0) {
            onPageSelected(0);
          } else {
            SystemNavigator.pop();
          }
          //  Navigator.pop(context);
        });
      },
      child: Scaffold(
        body: ValueListenableBuilder<int>(
          valueListenable: GlobalData.selectedIndexNotifier,
          builder: (context, index, child) {
            return IndexedStack(index: index, children: _pages);
          },
        ),
        bottomNavigationBar: SafeArea(
          bottom: false,
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              color: Color(0xFFFE9D1D),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 8.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ValueListenableBuilder<int>(
              valueListenable: GlobalData.selectedIndexNotifier,
              builder: (context, index, child) {
                return TabBar(
                  controller: _tabController,
                  onTap: onPageSelected,
                  labelStyle: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF105EF5),
                    fontFamily: "manrope_semibold",
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                    fontFamily: "manrope_semibold",
                  ),
                  labelPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  enableFeedback: true,
                  indicatorAnimation: TabIndicatorAnimation.elastic,
                  indicatorColor: Color(0xFF105EF5),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFF105EF5), width: 2.0),
                    ),
                  ),
                  tabs: [
                    Tab(
                      icon: Image.asset(
                        (GlobalData.selectedIndexNotifier.value == 0)?
                        'assets/images/icon_home_select.png':
                         'assets/images/icon_home.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Tab(
                      icon: Image.asset(
                          (GlobalData.selectedIndexNotifier.value == 1)?
                          'assets/images/icon_cart_select.png':
                          'assets/images/icon_cart.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Tab(
                      icon: Image.asset((GlobalData.selectedIndexNotifier.value == 2)?
                         'assets/images/icon_orders_select.png':
                        'assets/images/icon_orders.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Tab(
                      icon: Image.asset((GlobalData.selectedIndexNotifier.value == 3)
                          ?'assets/images/icon_profile_select.png':
                        'assets/images/icon_profile.png',
                        width: 30,
                        height: 28,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    ); //<- place where the image appears
  }
}
