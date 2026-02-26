import 'package:flutter/material.dart';

class CartItem {
  final int id;
  final String title;
  final double price;
  final String image;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}

class CartProvider with ChangeNotifier {
  // เก็บสินค้าในรูปแบบ Map <id, CartItem> เพื่อให้ค้นหาง่าย
  final Map<int, CartItem> _items = {};

  Map<int, CartItem> get items => _items;

  // นับจำนวนรายการสินค้าทั้งหมด (เช่น ตระกร้ามีสินค้า 3 ชนิด)
  int get itemCount => _items.length;

  // คำนวณราคารวมทั้งหมด
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  // เพิ่มสินค้าลงตระกร้า
  void addItem(int productId, String title, double price, String image) {
    if (_items.containsKey(productId)) {
      // ถ้ามีสินค้านี้อยู่แล้ว ให้เพิ่มจำนวน
      _items.update(
        productId,
        (existing) => CartItem(
          id: existing.id,
          title: existing.title,
          price: existing.price,
          image: existing.image,
          quantity: existing.quantity + 1,
        ),
      );
    } else {
      // ถ้ายังไม่มี ให้เพิ่มใหม่
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          price: price,
          image: image,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  // ลบสินค้าทีละ 1 ชิ้น
  void removeSingleItem(int productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existing) => CartItem(
          id: existing.id,
          title: existing.title,
          price: existing.price,
          image: existing.image,
          quantity: existing.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  // ลบสินค้าชนิดนั้นออกจากตระกร้าเลย
  void removeItem(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // ล้างตระกร้า
  void clear() {
    _items.clear();
    notifyListeners();
  }
}