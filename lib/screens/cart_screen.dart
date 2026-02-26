import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("ตระกร้าสินค้า"),
      ),
      body: Column(
        children: [
          // ส่วนแสดงรายการสินค้า
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text("ยังไม่มีสินค้าในตระกร้า"))
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (ctx, i) {
                      final item = items[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              // รูปภาพ
                              Container(
                                width: 60,
                                height: 60,
                                padding: const EdgeInsets.all(4),
                                child: Image.network(item.image, fit: BoxFit.contain),
                              ),
                              const SizedBox(width: 10),
                              // ชื่อและราคารวมต่อชิ้น
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "รวม: \$${(item.price * item.quantity).toStringAsFixed(2)}",
                                      style: const TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                              // ปุ่มเพิ่ม/ลด จำนวน
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline),
                                    onPressed: () {
                                      cart.removeSingleItem(item.id);
                                    },
                                  ),
                                  Text("${item.quantity}", style: const TextStyle(fontSize: 16)),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: () {
                                      cart.addItem(item.id, item.title, item.price, item.image);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          
          // ส่วนสรุปยอดเงินด้านล่าง
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, -5))],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("ราคารวมทั้งหมด:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      "\$${cart.totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: cart.items.isEmpty 
                      ? null 
                      : () {
                          // จำลองการสั่งซื้อ
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("สั่งซื้อเรียบร้อย!")),
                          );
                          cart.clear(); // ล้างตระกร้า
                          Navigator.pop(context);
                      },
                    child: const Text("ชำระเงิน", style: TextStyle(fontSize: 18)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}