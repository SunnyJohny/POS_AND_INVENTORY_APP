import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BugReport {
  final String title;
  final String description;
  final String? createdBy;
  final DateTime createdAt;
  bool isResolved;

  BugReport({
    required this.title,
    required this.description,
    this.createdBy,
    required this.createdAt,
    this.isResolved = false,
  });

  void markAsResolved() {
    isResolved = true;
  }
}

class BugReportWidget extends StatefulWidget {
  @override
  _BugReportWidgetState createState() => _BugReportWidgetState();
}

class _BugReportWidgetState extends State<BugReportWidget> {
  String title = '';
  String description = '';

  void submitBugReport() {
    // You can handle the bug report submission logic here
    // For example, you can create a BugReport object and pass the collected data to it
    BugReport bugReport = BugReport(
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );

    // Reset the input fields
    setState(() {
      title = '';
      description = '';
    });

    // Show a confirmation dialog or navigate to a success screen
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Bug Report Submitted'),
          content: Text('Thank you for reporting the bug!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void sendWhatsAppMessage() async {
    final Uri whatsappLaunchUri = Uri(
      scheme: 'https',
      host: 'api.whatsapp.com',
      path: 'send',
      queryParameters: {
        'phone': '08030611606', // Replace with your phone number
        'text': 'Bug Report: $title\n$description',
      },
    );

    if (await canLaunch(whatsappLaunchUri.toString())) {
      await launch(whatsappLaunchUri.toString());
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  void sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'johnsunday803@gmail.com', // Replace with your email address
      queryParameters: {
        'subject': 'Bug Report: $title',
        'body': description,
      },
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.phone),
              SizedBox(width: 8),
              Text('08030611606'),
              SizedBox(width: 16),
              GestureDetector(
                onTap: sendWhatsAppMessage,
                child: Row(
                  children: [
                    Icon(Icons.message),
                    SizedBox(width: 8),
                    Text('+2348030611606'),
                  ],
                ),
              ),
              SizedBox(width: 16),
              GestureDetector(
                onTap: sendEmail,
                child: Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 8),
                    Text('johnsunday803@gmail.com'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Bug Report',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                title = value;
              });
            },
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
          ),
          SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(
                onPressed: submitBugReport,
                child: Text('Save to DB'),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: sendWhatsAppMessage,
                child: Row(
                  children: [
                    Icon(Icons.message),
                    SizedBox(width: 8),
                    Text('WhatsApp'),
                  ],
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: sendEmail,
                child: Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 8),
                    Text('Email'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
