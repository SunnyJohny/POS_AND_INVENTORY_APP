import 'package:flutter/material.dart';
import 'package:my_desktop_app/screens/pos_screen.dart';
import 'package:my_desktop_app/screens/report/inventory_screen.dart';


class ReportSidePanel extends StatelessWidget {
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
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('path_to_image'), // Replace with the path to the user's profile image
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
            SizedBox(height: 16), // Add spacing between user info and modules

            Divider(),

            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Inventory Report'),
              onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => InventoryScreen()),
  );
},

            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Sales Report'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => PosScreen()),
                // );
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.trending_up),
              title: Text('Profit/Loss Report'),
              onTap: () {
                // Handle reports click
                Navigator.pushReplacementNamed(context, '/report');
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.people),
              title: Text('Top Customers Report'),
              onTap: () {
                // Handle user profile click
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.store),
              title: Text('Vendor/Supplier Report'),
              onTap: () {
                // Handle user profile click
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Employee Performance Report'),
              onTap: () {
                // Handle user profile click
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle settings click
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
          ],
        ),
      ),
    );
  }
}