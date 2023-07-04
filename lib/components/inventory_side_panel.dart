import 'package:flutter/material.dart';

class InventorySidePanel extends StatelessWidget {
  final Function(String) onItemSelected; // Callback for item selection

  InventorySidePanel({required this.onItemSelected});

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
              leading: Icon(Icons.add),
              title: Text('Add Product'),
              onTap: () {
                onItemSelected('Add Product'); // Invoke the callback with the selected item
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categories'),
              onTap: () {
                onItemSelected('Categories'); // Invoke the callback with the selected item
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Account'),
              onTap: () {
                onItemSelected('Account'); // Invoke the callback with the selected item
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.bug_report),
              title: Text('Report Bug'),
              onTap: () {
                onItemSelected('Report Bug'); // Invoke the callback with the selected item
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
