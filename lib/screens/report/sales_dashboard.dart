import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_desktop_app/components/custom_sales_report_modal.dart';

class SalesDashboard extends StatefulWidget {
  @override
  _SalesDashboardState createState() => _SalesDashboardState();
}

class _SalesDashboardState extends State<SalesDashboard> {
  int currentPage = 1;
  int itemsPerPage = 5;

  DateTime? fromDate;
  DateTime? toDate;

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
           itemsPerPage = 1; // Reassign itemsPerPage to 1

      setState(() {

        fromDate = selectedDate;
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        toDate = selectedDate;
           itemsPerPage = 1; // Reassign itemsPerPage to 4
      });
    }
  }

  List<Map<String, dynamic>> items = [
    {
      'sn': '1',
      'transactionId': 'TRX001',
      'date': '2023-07-15',
      'itemname': 'Phone',
      'customer': 'John Doe',
      'quantity': 5,
      'payment': 'Cash',
      'amount': 500.0,
      'attendant': 'Jane Smith',
      'status': 'Completed',
    },
    {
      'sn': '2',
      'transactionId': 'TRX002',
      'date': '${DateTime.now().toString().split(' ')[0]}',
      'itemname': 'Cream',
      'customer': 'Alice Johnson',
      'quantity': 6,
      'payment': 'Card',
      'amount': 250.0,
      'attendant': 'John Smith',
      'status': 'Completed',
    },
    {
      'sn': '3',
      'transactionId': 'TRX003',
      'date': '${DateTime.now().toString().split(' ')[0]}',
      'itemname': 'Paracetamol',
      'customer': 'Bob Williams',
      'quantity': 4,
      'payment': 'Cash',
      'amount': 700.0,
      'attendant': 'Jane Doe',
      'status': 'Pending',
    },
    {
      'sn': '4',
      'transactionId': 'TRX003',
      'date': '${DateTime.now().toString().split(' ')[0]}',
      'itemname': 'Paracetamol',
      'customer': 'Bob Williams',
      'quantity': 4,
      'payment': 'Cash',
      'amount': 700.0,
      'attendant': 'Jane Doe',
      'status': 'Pending',
    },
    {
      'sn': '3',
      'transactionId': 'TRX003',
      'date': '${DateTime.now().toString().split(' ')[0]}',
      'itemname': 'Paracetamol',
      'customer': 'Bob Williams',
      'quantity': 4,
      'payment': 'Cash',
      'amount': 700.0,
      'attendant': 'Jane Doe',
      'status': 'Pending',
    },
    {
      'sn': '3',
      'transactionId': 'TRX003',
      'date': '2023-07-01',
      'itemname': 'Paracetamol',
      'customer': 'Bob Williams',
      'quantity': 4,
      'payment': 'Cash',
      'amount': 700.0,
      'attendant': 'Jane Doe',
      'status': 'Pending',
    },
    {
      'sn': '3',
      'transactionId': 'TRX003',
      'date': '2023-07-02',
      'itemname': 'Paracetamol',
      'customer': 'Bob Williams',
      'quantity': 4,
      'payment': 'Cash',
      'amount': 700.0,
      'attendant': 'Jane Doe',
      'status': 'Pending',
    },
    {
      'sn': '3',
      'transactionId': 'TRX003',
      'date': '2023-07-03',
      'itemname': 'Paracetamol',
      'customer': 'Bob Williams',
      'quantity': 4,
      'payment': 'Cash',
      'amount': 700.0,
      'attendant': 'Jane Doe',
      'status': 'Pending',
    },

    // Add more items here...
  ];
  void sortItemsByDate() {
  items.sort((a, b) {
    // Convert the date strings to DateTime objects
    DateTime dateA = DateTime.parse(a['date']);
    DateTime dateB = DateTime.parse(b['date']);

    // Sort in descending order (latest date first)
    return dateB.compareTo(dateA);
  });
}


 List<Map<String, dynamic>> get paginatedItems {
  sortItemsByDate(); // Sort the items before pagination
  final startIndex = (currentPage - 1) * itemsPerPage;
  return items.skip(startIndex).take(itemsPerPage).toList();
}


  int get totalItems => items.length;
  int get totalPages => (totalItems / itemsPerPage).ceil();
  List<Map<String, dynamic>> get filteredItems {
    if (_searchText.isEmpty && fromDate == null && toDate == null) {
      return paginatedItems;
    } else {
      return items.where((item) {
        // Filter based on item name search
        final bool itemNameMatches =
            item['itemname'].toLowerCase().contains(_searchText.toLowerCase());

        // Filter based on date range selection
        final bool isDateInRange = (fromDate == null ||
                (item['date'] != null &&
                    DateTime.parse(item['date']).isAtSameMomentAs(fromDate!)) ||
                (item['date'] != null &&
                    DateTime.parse(item['date']).isAfter(fromDate!))) &&
            (toDate == null ||
                (item['date'] != null &&
                    DateTime.parse(item['date']).isAtSameMomentAs(toDate!)) ||
                (item['date'] != null &&
                    DateTime.parse(item['date'])
                        .isBefore(toDate!.add(Duration(days: 1)))));

        // Return true if item name and date range both match
        return itemNameMatches && isDateInRange;
      }).toList();
    }
  }

  double getTodaySales() {
    var now = DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(now);

    double totalSales = 0;
    for (var item in items) {
      if (item['date'] == formattedDate) {
        totalSales += item['amount'];
      }
    }
    return totalSales;
  }

double getTotalSales() {
  if (_searchText.isEmpty && fromDate == null && toDate == null) {
    // If nothing is filtered, return the total sales from the original items list
    double totalSales = 0;
    for (var item in items) {
      totalSales += item['amount'];
    }
    return totalSales;
  } else {
    // If there are filters, calculate the total sales from the filtered items list
    double totalSales = 0;
    for (var item in filteredItems) {
      totalSales += item['amount'];
    }
    return totalSales;
  }
}


void _printSalesReport(BuildContext context) async {
  // ... (existing code to print to console and show toasts)

  // Navigate to a new page and display the CustomSalesReportModal
  final bool shouldPrintReport = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Print Sales Report'),
      content: Text('Do you want to print the sales report?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, true); // Return true when user confirms
          },
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, false); // Return false when user cancels
          },
          child: Text('No'),
        ),
      ],
    ),
  );

  // Show a toast based on the user's choice
  if (shouldPrintReport == true) {
    Fluttertoast.showToast(
      msg: 'Sales report is being printed...',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // Add a short delay to mimic the actual printing process (remove this in the actual implementation)
    await Future.delayed(Duration(seconds: 2));

    // Show the custom modal with the sales report
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomSalesReportModal(
          attendantName: 'John Doe', // Provide the attendant's name
          cartItems: filteredItems, // Use the filteredItems instead of cartItems
          total: getTotalSales(), // Use the total sales instead of total
        ),
      ),
    );

    // Show a toast to indicate that printing is completed
    Fluttertoast.showToast(
      msg: 'Sales report printed successfully!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } else {
    // User chose not to print the report, show a message if needed
    Fluttertoast.showToast(
      msg: 'Sales report printing canceled!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}




  int getProductsSoldToday() {
    var now = DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(now);

    int productsSold = 0;
    for (var item in items) {
      if (item['date'] == formattedDate) {
        productsSold += item['quantity'] as int;
      }
    }
    return productsSold;
  }

  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Sales Stats',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard(
                'Today Sales',
                '₦${getTodaySales().toStringAsFixed(2)}',
                Icons.attach_money,
                Colors.blue,
              ),
              SizedBox(width: 16),
              _buildStatCard(
                'Total Sales',
                '₦${getTotalSales().toStringAsFixed(2)}',
                Icons.monetization_on,
                Colors.green,
              ),
              SizedBox(width: 16),
              _buildStatCard(
                'Today Invoices',
                '',
                Icons.receipt,
                Colors.orange,
              ),
              SizedBox(width: 16),
              _buildStatCard(
                'Products Sold Today',
                getProductsSoldToday(),
                Icons.shopping_cart,
                Colors.red,
              ),
            ],
          ),
          SizedBox(height: 16),
          Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sales By Time Period :  ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('FROM: '),
                  GestureDetector(
                    onTap: () => _selectFromDate(context),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 8),
                        Text(
                          fromDate != null
                              ? DateFormat('dd-MM-yyyy').format(fromDate!)
                              : 'Select Date',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Text('TO: '),
                  GestureDetector(
                    onTap: () => _selectToDate(context),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 8),
                        Text(
                          toDate != null
                              ? DateFormat('dd-MM-yyyy').format(toDate!)
                              : 'Select Date',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    margin: EdgeInsets.only(top: 2, right: 2),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Sales By Product',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Today's (${DateFormat('dd-MM-yyyy').format(DateTime.now())}) Transactions",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          DataTable(
            columns: [
              DataColumn(label: Text('Transaction ID')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Attendant')),
              DataColumn(label: Text('Item Name')),
              DataColumn(label: Text('Qty')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Payment')),
              DataColumn(label: Text('Status')),
            ],
            rows: filteredItems
                .map(
                  (item) => DataRow(
                    cells: [
                      DataCell(Text(item['transactionId'])),
                      DataCell(Text(item['date'])),
                      DataCell(Text(item['attendant'])),
                      DataCell(Text(item['itemname'])),
                      DataCell(Text(item['quantity'].toString())),
                      DataCell(Text('₦${item['amount'].toStringAsFixed(2)}')),
                      DataCell(Text(item['payment'])),
                      DataCell(Text(item['status'])),
                    ],
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 8),
                  child: ElevatedButton(
                    onPressed: currentPage > 1
                        ? () {
                            setState(() {
                              currentPage--;
                            });
                          }
                        : null,
                    child: Text('Previous'),
                  ),
                ),
              ),
              Text('Page $currentPage of $totalPages'),
              // Add the "Print Sales Report" button
       ElevatedButton(
  onPressed: () => _printSalesReport(context),
  child: Text('Print Sales Report'),
),

              Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  child: ElevatedButton(
                    onPressed: currentPage < totalPages
                        ? () {
                            setState(() {
                              currentPage++;
                            });
                          }
                        : null,
                    child: Text('Next'),
                  ),
                  
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, dynamic value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
