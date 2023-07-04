import 'package:flutter/material.dart';
import 'package:my_desktop_app/components/product.dart';
import 'package:my_desktop_app/components/cart_panel.dart';
import 'package:my_desktop_app/components/inventory_side_panel.dart';
import 'package:my_desktop_app/screens/report/dashboard.dart';
import 'package:my_desktop_app/screens/report/bug_report.dart';

import 'package:my_desktop_app/screens/report/add_product_screen.dart';


import 'package:provider/provider.dart';
import 'package:my_desktop_app/components/providers/product_cart_provider.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String selectedItem = 'Dashboard'; // Hardcoded selected item

  Widget renderSelectedWidget() {
    switch (selectedItem) {
      case 'Inventory Report':
        return Text('Render Inventory Report Widget here');
      case 'Add Product':
        return AddProductScreen();
      case 'Categories':
        return Text('Render Categories Widget here');
      case 'Account':
        return Text('Render Account Widget here');
      case 'Report Bug':
        return BugReportWidget();
      case 'Dashboard':
        return Dashboard(); // Render the Dashboard widget
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Screen'),
      ),
      body: Row(
        children: [
          InventorySidePanel(
            onItemSelected: (itemName) {
              setState(() {
                selectedItem = itemName;
              });
            },
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Inventory Report',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(height: 10),
                  
                  // SizedBox(height: 10),
                  // Text('Selected Item: $selectedItem'),
                  // SizedBox(height: 10),
                  renderSelectedWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
