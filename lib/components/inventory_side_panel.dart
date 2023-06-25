import 'package:flutter/material.dart';
import 'package:my_desktop_app/screens/pos_screen.dart';
import 'package:my_desktop_app/screens/report/inventory_screen.dart';

class InventorySidePanel extends StatelessWidget {
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
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                // Handle dashboard click
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Product'),
              onTap: () {
                // Handle add product click
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categories'),
              trailing: DropdownButton(
                onChanged: (value) {
                  // Handle category dropdown value change
                },
                value: null, // Set the selected category value
                items: [], // Add DropdownMenuItem widgets for each category
              ),
              onTap: () {
                // Handle categories click
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Account'),
              onTap: () {
                // Handle account click
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.bug_report),
              title: Text('Report Bug'),
              onTap: () {
                // Handle report bug click
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
