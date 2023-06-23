import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Image.network(
                    'https://cdn.dribbble.com/users/1387827/screenshots/15466426/media/deb2dca6762cd3610321c98bfccb0b72.png?compress=1&resize=1200x900',
                    // Replace with your logo image URL
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'POS&INVENTORY MANAGEMENT SYSTEM',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Time: ${DateFormat('HH:mm:ss').format(DateTime.now())}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color:
            Color.fromARGB(255, 246, 188, 207), // Set background color to pink
        child: Row(
          children: [
            Expanded(
              child: Image.network(
                'https://cdn.dribbble.com/users/1387827/screenshots/15466426/media/deb2dca6762cd3610321c98bfccb0b72.png?compress=1&resize=1200x900',
                width: 200,
                height: 800,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Password',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 50, // Increase the height of the button
                      child: ElevatedButton(
                        child: Text('Login'),
                        onPressed: () {
                          // Perform login authentication
                          // If login is successful, navigate to the home page
                          Navigator.pushReplacementNamed(context, '/pos');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Add border radius
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text('Register'),
                      onPressed: () {
                        // Navigate to the registration page
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
