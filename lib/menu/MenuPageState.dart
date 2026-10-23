import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../model/Category.dart';
import '../model/Cart.dart';
import '../utils/CartModel.dart';
import '../utils/Constants.dart';
import '../utils/GlobalData.dart';
import 'MenuPage.dart';

class MenuPageState extends State<MenuPage> {
  Category? category;
  late final CartModel cartModel;

  @override
  void initState() {
    super.initState();

    // Use the shared cart instance.
    cartModel = GlobalData.cartModel!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg is Category) {
        setState(() {
          category = arg;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F1F1),
      body: Column(
        children: [
          // Header
          Stack(
            children: [
              AppBar(
                title: Text(
                  "Categories",
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

          if (category == null)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else ...[
            Padding(
              padding: const EdgeInsets.only(left: 18, ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  category!.categoryName,
                  style: const TextStyle(
                    fontFamily: 'poppins_bold',
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            // Menu list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 15),
                physics: const BouncingScrollPhysics(),
                itemCount: category!.items?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = category!.items![index];

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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      rating: (item.averageRating.toDouble())
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
                                        final quantity = cartModel.getQuantity(
                                          item.itemId,
                                        );

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
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            child: Container(
                                              height: 30,
                                              width: 85,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: const Color(0xFFD9D9D9),
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
                                                cartModel.decreaseQuantity(
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
                                                cartModel.increaseQuantity(
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
            ),
          ],
        ],
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
