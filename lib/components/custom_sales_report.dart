import 'package:flutter/material.dart';
import 'package:my_desktop_app/components/custom_sales_report_modal.dart';
import 'package:my_desktop_app/components/product.dart';

class CustomSalesReport extends StatelessWidget {
  final double total;
List<Product> cartItems = []; // Initialize 'cartItems' as an empty list

  CustomSalesReport({this.total = 0.0}); // Assign a default value for 'total'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Sales Report'),
      ),
      body:  Center(
          child: CustomSalesReportModal(
        attendantName: 'John Doe', // Provide the attendant's name
        cartItems: [],
        total: total,
      )),
    );
  }
}
