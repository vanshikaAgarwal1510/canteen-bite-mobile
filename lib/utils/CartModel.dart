import 'dart:convert';
import 'package:canteen_bite_mobile/Dashboard/cart/Cart.dart';
import 'package:flutter/cupertino.dart';
import '../model/Cart.dart';
import 'GlobalData.dart';

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];
  double discount = 0;
  bool isCouponApplied = false;
  String? appliedCouponCode;
  Future<void> Function()? onCartChanged;
  int orderType = 0;


  List<CartItem> get items => List.unmodifiable(_items);

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subTotal =>
      _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  double get total => subTotal - (isCouponApplied ? discount : 0);

  CartItem? getItem(int id) {
    for (final item in _items) {
      if (item.itemId == id) return item;
    }
    return null;
  }

  void addItem(CartItem item) {
    final index = _items.indexWhere((e) => e.itemId == item.itemId);

    if (index != -1) {
      final existing = _items[index];
      _items[index] = existing.copyWith(quantity: existing.quantity + 1);
    } else {
      _items.add(item);
    }

    _saveAndNotify();
  }

  void increaseQuantity(int id) {
    final index = _items.indexWhere((item) => item.itemId == id);

    if (index == -1) return;

    final item = _items[index];
    _items[index] = item.copyWith(quantity: item.quantity + 1);

    _saveAndNotify();
  }

  void decreaseQuantity(int id) {
    final index = _items.indexWhere((item) => item.itemId == id);

    if (index == -1) return;

    final item = _items[index];

    if (item.quantity <= 1) {
      _items.removeAt(index);
    } else {
      _items[index] = item.copyWith(quantity: item.quantity - 1);
    }

    _saveAndNotify();
  }

  void removeItem(int id) {
    _items.removeWhere((item) => item.itemId == id);
    _saveAndNotify();
  }

  void clearCart() {
    _items.clear();
    isCouponApplied = false;
    appliedCouponCode = null;
    discount = 0;
    orderType = 0;
    _saveAndNotify();
  }

  void _saveAndNotify() {
    notifyListeners();
    saveCart();
    GlobalData.cartLength.value = totalItems;
    if (isCouponApplied && onCartChanged != null) {
      onCartChanged!();
    }
  }

  Future<void> saveCart() async {
    final jsonList = _items.map((item) => jsonEncode(item.toJson())).toList();
    GlobalData.localDataStore.setCart(jsonList);
  }

  Future<void> loadCart() async {
    final list = GlobalData.localDataStore.getCartList();

    if (list == null) return;

    _items
      ..clear()
      ..addAll(
        list.map(
          (e) => CartItem.fromJson(jsonDecode(e) as Map<String, dynamic>),
        ),
      );

    GlobalData.cartLength.value = totalItems;
    notifyListeners();
  }

  bool contains(int id) {
    return _items.any((item) => item.itemId == id);
  }

  int getQuantity(int id) {
    final index = _items.indexWhere((item) => item.itemId == id);

    if (index == -1) return 0;

    return _items[index].quantity;
  }

void setOrderType(int type) {
  if (type != 1 && type != 2) return;

  orderType = type;
  notifyListeners();
} }  