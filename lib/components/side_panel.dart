import 'package:flutter/material.dart';


class SidePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // User information
    String userName = "John Doe";
    String userPosition = "Software Developer";
    String userId = "12345";

    return Container(
      width: 200,
      color: Colors.grey[200],
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
          Divider(),
          ListTile(
            leading: Icon(Icons.inventory),
            title: Text('Inventory'),
            onTap: () {
              // Handle inventory click
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => InventoryScreen()),
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Products Page'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => PosScreen()),
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Reports'),
            onTap: () {
              // Handle reports click
               Navigator.pushReplacementNamed(context, '/report');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('User Profile'),
            onTap: () {
              // Handle user profile click
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle settings click
            },
          ),
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
    );
  }
}
