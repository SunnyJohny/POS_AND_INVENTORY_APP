import 'package:flutter/material.dart';
import 'package:my_desktop_app/components/receipt_modal.dart';
import 'package:my_desktop_app/components/product.dart';

class ReceiptScreen extends StatelessWidget {
  final List<Product> cartItems;
  final double total;

  ReceiptScreen({required this.cartItems, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: Center(
          child: ReceiptModal(
        attendantName: 'John Doe', // Provide the attendant's name
        cartItems: cartItems,
        total: total,
      )),
    );
  }
}
