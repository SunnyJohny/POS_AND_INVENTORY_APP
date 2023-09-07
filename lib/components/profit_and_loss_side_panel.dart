import 'package:flutter/material.dart';

class ProfitAndLossReportSidePanel extends StatelessWidget {
  final Function(String) onItemSelected; // Callback for item selection

 ProfitAndLossReportSidePanel({required this.onItemSelected});

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
  leading: Icon(Icons.dashboard), // Icon for Dashboard
  title: Text('Dashboard'),
  onTap: () {
    onItemSelected('Dashboard'); // Invoke the callback with the selected item
  },
),

Divider(),

ListTile(
  leading: Icon(Icons.receipt_long), // Icon for Post Expense
  title: Text('Expenses'),
  onTap: () {
    onItemSelected('Expenses'); // Invoke the callback with the selected item
  },
),

Divider(),

ListTile(
  leading: Icon(Icons.money), // Icon for Income Statement
  title: Text('Income Statement'),
  onTap: () {
    onItemSelected('Customer'); // Invoke the callback with the selected item
  },
),

Divider(),

ListTile(
  leading: Icon(Icons.attach_money), // Icon for Total Revenue
  title: Text('Total Revenue'),
  onTap: () {
    onItemSelected('Products'); // Invoke the callback with the selected item
  },
),

Divider(),

ListTile(
  leading: Icon(Icons.analytics), // Icon for Analysis
  title: Text('Analysis'),
  onTap: () {
    onItemSelected('Analysis'); // Invoke the callback with the selected item
  },
),

Divider(),

ListTile(
  leading: Icon(Icons.description), // Icon for Custom Report
  title: Text('Custom Report'),
  onTap: () {
    onItemSelected('Custom Report'); // Invoke the callback with the selected item
  },
),

Divider(),

ListTile(
  leading: Icon(Icons.logout), // Icon for Logout
  title: Text('Logout'),
  onTap: () {
    // Handle logout click
    // After logout, navigate back to the login page
    Navigator.pushReplacementNamed(context, '/login');
  },
),


            // Divider(),

const ListTile(
              // this tile is just meant to add height to the panel
            ),
          ],
        ),
      ),
    );
  }
}
