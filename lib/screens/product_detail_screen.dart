import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final dynamic product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // แปลงค่า price เป็น double ให้ชัวร์
    final double price = double.parse(product['price'].toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(product['title'], style: const TextStyle(fontSize: 16)),
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              label: Text(cart.itemCount.toString()),
              isLabelVisible: cart.itemCount > 0,
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Hero(
                tag: product['id'],
                child: Image.network(product['image'], fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: const TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product['title'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product['description'],
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 80), // เผื่อพื้นที่ให้ปุ่มด้านล่าง
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
          ),
          icon: const Icon(Icons.add_shopping_cart),
          label: const Text("เพิ่มลงตระกร้า", style: TextStyle(fontSize: 18)),
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false).addItem(
              product['id'],
              product['title'],
              price,
              product['image'],
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("เพิ่มสินค้าลงตระกร้าแล้ว"),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}