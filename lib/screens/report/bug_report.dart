import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          ElevatedButton(
            onPressed: submitBugReport,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
