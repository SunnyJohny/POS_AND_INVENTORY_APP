import 'package:flutter/material.dart';
import 'package:my_desktop_app/components/product.dart';
import 'package:my_desktop_app/components/cart_panel.dart';
import 'package:my_desktop_app/components/sales_report_side_panel.dart';
import 'package:my_desktop_app/components/custom_sales_report.dart';

import 'package:my_desktop_app/screens/report/sales_dashboard.dart';

import 'package:my_desktop_app/screens/report/analytsis_dashboard.dart';


import 'package:my_desktop_app/screens/report/bug_report.dart';

import 'package:my_desktop_app/screens/report/add_product_screen.dart';

import 'package:provider/provider.dart';
import 'package:my_desktop_app/components/providers/product_cart_provider.dart';

class SalesReportScreen extends StatefulWidget {
  @override
  _SalesReportScreenState createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  String selectedItem = 'Dashboard'; // Hardcoded selected item

  Widget renderSelectedWidget() {
    switch (selectedItem) {
      case 'Sales Report':
        return Text('Render Sales Report Widget here');
      case 'Add Product':
        return AddProductScreen();
      case 'Analysis':
        return AnalysisDashboard();
      case 'Account':
        return Text('Render Account Widget here');
      case 'Custom Report':
     
       return CustomSalesReport();
        // return AddProductScreen();


       case 'Dashboard':
        return SingleChildScrollView( // Wrap SalesDashboard with SingleChildScrollView
          child: SalesDashboard(),
        );
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Report'),
      ),
      body: Row(
        children: [
          SalesReportSidePanel(
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
                    'Sales Report',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
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
