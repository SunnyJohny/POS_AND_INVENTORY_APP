import 'package:flutter/material.dart';

class SalesReportSidePanel extends StatelessWidget {
  final Function(String) onItemSelected; // Callback for item selection

 SalesReportSidePanel({required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    // User information
    String userName = "John Doe";
    String userPosition = "Software Developer";
    String userId = "12345";

    return Container(
      width: 300,
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue, // Replace with your desired color
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    userName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    userPosition,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "User ID: $userId",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 26), // Add spacing between user info and modules

            Divider(),

            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Dashboard'),
              onTap: () {
                onItemSelected('Dashboard'); // Invoke the callback with the selected item
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.receipt),
              title: Text('Invoices/Payments'),
              onTap: () {
                onItemSelected('Invoices'); // Invoke the callback with the selected item
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.people),
              title: Text('Customer'),
              onTap: () {
                onItemSelected('Customer'); // Invoke the callback with the selected item
              },
            ),
             Divider(),

            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Products'),
              onTap: () {
                onItemSelected('Products'); // Invoke the callback with the selected item
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.analytics),
              title: Text('Analysis'),
              onTap: () {
                onItemSelected('Analysis'); // Invoke the callback with the selected item
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.receipt_long),
              title: Text('Custom Report'),
              onTap: () {
                onItemSelected('Custom Report'); // Invoke the callback with the selected item
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Handle logout click
                // After logout, navigate back to the login page
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),

            // Divider(),

            ListTile(
              // this tile is just meant to add height to the panel
            ),
          ],
        ),
      ),
    );
  }
}
