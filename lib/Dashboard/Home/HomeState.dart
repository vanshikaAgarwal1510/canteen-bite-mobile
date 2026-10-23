import 'dart:collection';
import 'dart:convert';
import 'package:canteen_bite_mobile/model/Category.dart';
import 'package:canteen_bite_mobile/model/Menu.dart';
import 'package:canteen_bite_mobile/utils/Constants.dart';
import 'package:canteen_bite_mobile/utils/GlobalData.dart';
import 'package:canteen_bite_mobile/webservice/response/MenuResponse.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../utils/ShowErrorException.dart';
import '../../utils/network/NetworkException.dart';
import '../../webservice/ApiCall.dart';
import 'Home.dart';
import '../../Menu/MenuPage.dart';

class HomeState extends State<Home> {
  int _currentIndex = 0;
  List<MenuItem> recommendMenuItems = [];
  List<Category>menu =[];

 void getData(){
    final recommendData =
    GlobalData.localDataStore.getRecommendItems();
    recommendMenuItems = recommendData!.map((item)=>MenuItem.fromJson(jsonDecode(item))).toList();
    print(recommendData);
    final menuData = GlobalData.localDataStore.getMenu();
    menu= menuData!.map((item)=>Category.fromJson(jsonDecode(item))).toList();

  }

 double calculateRating(Category category){
    int sum=0;
    for(var item in category.items!){
      sum+=item.averageRating;
    }
    return sum/category.items!.length;
  }

  Category getCategory(int id){
   Category selectedCategory = menu.firstWhere((category) => category.categoryId == id);
   return selectedCategory;
  }

    Future<void> fetchMenu() async {
      ApiCall apiCall = ApiCall();

      Map<String, dynamic> request = HashMap();
      request.addAll({
        "apikey":Constants.apiKey,
      });

      try {
        MenuResponse response =  await apiCall.fetchMenu(request);

        setState(() {
          menu = response.categories;
          //List<String> menuList = response.categories.map((item)=>jsonEncode(item)).toList();
         // GlobalData.localDataStore.setMenu(menuList);
        });
      }  on NetworkException catch(networkException) {
        if(context.mounted){
          GlobalData.showOkayDialog(context, networkException.toString());
        }
      } on ShowErrorException catch(exception) {
        if(context.mounted){
          GlobalData.showOkayDialog(context, exception.message!);
        }
      } catch(exception) {
        if(context.mounted){
          GlobalData.showOkayDialog(context, exception.toString());
        }
      }
    }

  @override
  void initState() {
    super.initState();
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
     fetchMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F1F1),
      body: Stack(
        children: [
          Container(
            height: 335,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/food_doodle.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withValues(alpha: 0.4),
                  BlendMode.srcIn,
                ),
              ),
              color: Color(0xFFFE9D1D),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(35),
                bottomLeft: Radius.circular(35),
              ),
              boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
            ),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.paddingOf(context).top),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "poppins_bold",
                          color: Colors.white,
                        ),
                      ),
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/icon_notification.png',
                            height: 25,
                          ),
                          Positioned(
                            right: 2,
                            top: 4,
                            child: Container(
                              height: 6,
                              width: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFDB3F40),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
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
                SizedBox(height: 8),
                Expanded(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 16/7.6,
                      autoPlay: true,
                      enlargeCenterPage: false,
                      viewportFraction: 1,
                      autoPlayInterval: const Duration(seconds: 7),
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 1200,
                      ),
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: [
                      sliderCard(
                        "ORDER WITHIN SECONDS VIA",
                        "UPI PAYMENT",
                        "Choose your favorite item and complete the order within seconds",
                        'assets/images/illustrator4.png',
                        'assets/images/illustrator3.png',
                        "Choose",
                      ),
                      sliderCard(
                        "WELCOME OFFER",
                        "₹50 OFF ON FIRST ORDER",
                        "New here? Get ₹50 off on your first order and enjoy. Use Code WELCOME50",
                        'assets/images/illustrator5.png',
                        'assets/images/illustrator1.png',
                        "Apply",
                      ),
                      sliderCard(
                        "SPECIAL OFFER FOR",
                        "UNIVERSITY STUDENTS",
                        "Save 10 % on every order, valid only for campus students. Use Code SAVE10",
                        'assets/images/illustrator7.png',
                        'assets/images/illustrator6.png',
                        "Apply",
                      ),
                    ],
                  ),
                ),
                AnimatedSmoothIndicator(
                  activeIndex: _currentIndex,
                  count: 3,
                  effect: ExpandingDotsEffect(
                  dotHeight: 7,
                  dotWidth: 7,
                  expansionFactor: 3,
                  spacing: 6,
                  dotColor: Colors.grey.shade300,
                  activeDotColor: const Color(0xFF16171B),
                ),
                ),
                SizedBox(height: 8),

              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20,355 , 20, 20),
            padding: EdgeInsets.all(0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Recommended for you",style: TextStyle(fontSize: 16,fontFamily: "poppins_semibold"),),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 105,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recommendMenuItems.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){ Navigator.pushNamed(context, MenuPage.routeName,arguments: getCategory(recommendMenuItems[index].categoryID!));
                          },
                          child: Container(
                            width: 150,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFFFCFCFC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xFF779830),width: 1),
                              boxShadow: [BoxShadow(color: Colors.black45,blurRadius: 5,blurStyle: BlurStyle.outer,),]
                            ),
                           child:Column(
                             children: [
                               Container(
                                 width: double.infinity,
                                 height: 80,
                                 child: ClipRRect(
                                   borderRadius: BorderRadius.only(topLeft: Radius.circular(6),topRight: Radius.circular(6)),
                                   child: (recommendMenuItems[index].imageUrl!=null &&recommendMenuItems[index].imageUrl!.isNotEmpty)?
                                     Image.network(Constants.BASE_URL+recommendMenuItems[index].imageUrl!,fit: BoxFit.cover)
                                       :Image.asset("assets/images/food_placeholder.png",fit: BoxFit.cover,),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                 child: Text(recommendMenuItems[index].itemName,style: TextStyle(fontSize: 14,fontFamily: "poppins",fontWeight: FontWeight.w500),overflow:TextOverflow.ellipsis),
                               )
                             ],
                           ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
              
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "poppins_semibold",
                    ),
                  ),

              
                  ListView.builder(
                    itemCount: menu.length, // Important: limits the number of items
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final category = menu[index];
              
                      return InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, MenuPage.routeName,arguments: category);
                        },
                        child: Container(
                          height: 120,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF779830),
                              width: 1,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 5,
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                          ),
                        child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(
                        width: 120,
                        height: 140,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                        child: (category.imageUrl != null &&
                        category.imageUrl!.isNotEmpty)
                        ? Image.network(
                        Constants.BASE_URL + category.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                        "assets/images/illustrator8.png",
                        fit: BoxFit.cover,
                        );
                        },
                        )
                            : Image.asset(
                        "assets/images/illustrator8.png",
                        fit: BoxFit.cover,
                        ),
                        ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const SizedBox(height: 15),

                        Text(
                        category.categoryName,
                        style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "poppins_semibold",
                        color: Color(0xFF16171B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 4),

                        Row(
                        children: [
                        RatingBar.builder(
                        initialRating: calculateRating(category)
                            .clamp(0.0, 5.0),
                        ignoreGestures: true,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemSize: 18,
                        itemCount: 5,
                        itemPadding:
                        const EdgeInsets.only(right: 4),
                        itemBuilder: (context, index) =>
                        const Icon(
                        Icons.star,
                        color: Color(0xFF779830),
                        ),
                        onRatingUpdate: (_) {},
                        ),

                        const SizedBox(width: 5),

                        Text(
                        "(${calculateRating(category)})",
                        style: const TextStyle(
                        fontSize: 12,
                        fontFamily: "poppins",
                        ),
                        ),
                        ],
                        ),

                        const SizedBox(height: 5),

                        Text(
                        category.categoryDescription ??
                        "This is a description about this category.",
                        style: const TextStyle(
                        fontSize: 12,
                        fontFamily: "poppins",
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        ),
                        ],
                        ),
                        ),
                        ],
                        )

                        ),
                      );
                    },
                  ),
              
                ],
              ),
            ),
          )
              ],
      ),
    );
  }

  Widget sliderCard(
    String title,
    String subtitle,
    String description,
    String imgUrl1,
    String imgUrl2,
    String btn_title,
  ) {
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 62.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 21.5,
                    color: Colors.white,
                    fontFamily: "patrick",
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 21.5,
                    color: Colors.white,
                    fontFamily: "patrick",
                    fontWeight: FontWeight.w600,
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
                SizedBox(height: 6),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    btn_title,
                    style: TextStyle(fontFamily: "poppins_medium"),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF16171B),
                    foregroundColor: Color(0xFFFCFCFC),
                    minimumSize: Size(80, 35),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -15,
            top: 0,
            child: Image.asset(imgUrl1),
            height: 100,
            width: 100,
          ),
          Positioned(
            left: -15,
            bottom: 10,
            child: Image.asset(imgUrl2),
            height: 100,
            width: 100,
          ),
        ],
      ),
    );
  }
}
