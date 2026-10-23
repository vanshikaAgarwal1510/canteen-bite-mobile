
import 'package:flutter/material.dart';
import '../../model/Cart.dart';

class OrderSummaryCard extends StatelessWidget {
  final List<CartItem> items;
  final double discount;


  const OrderSummaryCard({
    super.key,
    required this.items,
    this.discount = 0,
  });

  static const Color green = Color(0xFF789B2D);
  static const Color dark = Color(0xFF20211F);
  static const Color muted = Color(0xFF85877F);
  static const Color cream = Color(0xFFF8FAF3);

  double get subtotal => items.fold<double>(
    0,
        (sum, item) => sum + item.totalPrice,
  );

  double get appliedDiscount =>
      discount.clamp(0.0, subtotal).toDouble();

  double get total => subtotal - appliedDiscount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Color(0xFFFE9D1D).withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF343A2A).withValues(alpha: 0.09),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card heading
          Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFFE9D1D).withAlpha(50),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.receipt_long_rounded,
                  color: Color(0xFFFE9D1D),
                  size: 23,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Summary',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: "poppins_bold",
                        color: dark,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Price details',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "poppins",
                        color: muted,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFE9D1D).withAlpha(50),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${items.fold<int>(0, (sum, item) => sum + item.quantity)} items',
                  style: const TextStyle(
                    color: Color(0xFFFE9D1D),
                    fontSize: 12,
                    fontFamily: "poppins_bold"
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // Itemized prices
          ...items.map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.itemName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: dark,
                        fontFamily: "poppins_semibold"
                      ),
                    ),
                  ),
                 /* const SizedBox(width: 8),
                  Text(
                    '${item.quantity} × ₹${item.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: "poppins",
                      color: muted,
                    ),
                  ),*/
                  const SizedBox(width: 12),
                  Text(
                    '₹${item.totalPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: dark,
                        fontFamily: "poppins_semibold"
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Divider(
            color: Color(0xFFE8EAE3),
            thickness: 1,
          ),

          const SizedBox(height: 14),

          _priceRow('Subtotal', subtotal),

          const SizedBox(height: 14),

          // Discount row
          if(discount>0.0)Row(
            children: [
              const Icon(
                Icons.local_offer_rounded,
                color: green,
                size: 17,
              ),
              const SizedBox(width: 7),
              const Expanded(
                child: Text(
                  'Discount',
                  style: TextStyle(
                    fontSize: 14,
                    color: green,
                    fontFamily: "poppins_bold"
                  ),
                ),
              ),
              if (appliedDiscount > 0)
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF5DF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'SAVED',
                    style: TextStyle(
                      color: green,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              Text(
                '- ₹${appliedDiscount.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: green,
                  fontSize: 14,
                    fontFamily: "poppins_bold"
                ),
              ),
            ],
          ),

          if(discount>0.0)const SizedBox(height: 18),

          // Highlighted total
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 0),
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(15),

            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "poppins_bold",
                          color: dark,
                        ),
                      ),
                      if (appliedDiscount > 0) ...[
                        const SizedBox(height: 4),
                        Text(
                          'You save ₹${appliedDiscount.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: dark,
                            fontSize: 11,
                              fontFamily: "poppins_semibold"
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Text(
                  '₹${total.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: "poppins_bold",
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _priceRow(String label, double amount) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: muted,
                fontFamily: "poppins_semibold"
            ),
          ),
        ),
        Text(
          '₹${amount.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 14,
            color: dark,
              fontFamily: "poppins_bold"
          ),
        ),
      ],
    );
  }
}
