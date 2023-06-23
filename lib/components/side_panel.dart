import 'package:flutter/material.dart';
import 'package:my_desktop_app/screens/pos_screen.dart';

class SidePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.grey[200],
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.inventory),
            title: Text('Inventory'),
            onTap: () {
              // Handle inventory click
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Products Page'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PosScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Reports'),
            onTap: () {
              // Handle reports click
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
