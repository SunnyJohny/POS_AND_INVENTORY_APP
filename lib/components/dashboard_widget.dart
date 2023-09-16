import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_desktop_app/components/custom_sales_report_modal.dart';
import 'package:my_desktop_app/components/profitandlossmodal.dart';

import 'package:pdf/pdf.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

// Define a class for your dashboard widget
class DashboardWidget extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> items; // This will hold your data
  final void Function() printReportCallback; // Callback for printing reports

  // Constructor to initialize the widget
  DashboardWidget({
    required this.title,
    required this.items,
    required this.printReportCallback,
  });

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
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
      });
    }
  }

//   Future<void> generateIncomeStatement(
//   double revenue,
//   double cogs,
//   double opex,
//   double profit,
// ) async {
//   final pdf = pw.Document();

//   // Add a page to the PDF
//   pdf.addPage(
//     pw.Page(
//       build: (context) {
//         return pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             // Add the title at the top
//             pw.Center(child: pw.Text('Income Statement', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold))),
//             pw.SizedBox(height: 20),
//             // Add revenue, COGS, opex, and profit
//             pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Text('Revenue:'),
//                 pw.Text('N${revenue.toStringAsFixed(2)}'),
//               ],
//             ),
//             pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Text('Cost of Goods Sold (COGS):'),
//                 pw.Text('N${cogs.toStringAsFixed(2)}'),
//               ],
//             ),
//             pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Text('Operating Expenses (Opex):'),
//                 pw.Text('N${opex.toStringAsFixed(2)}'),
//               ],
//             ),
//             pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Text('Profit:'),
//                 pw.Text('N${profit.toStringAsFixed(2)}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//               ],
//             ),
//           ],
//         );
//       },
//     ),
//   );

  // Save the PDF to a file
  // final pdfFile = File('income_statement.pdf');
  // await pdfFile.writeAsBytes(await pdf.save());

  // You can now share, print, or display the PDF as needed
  // For example, you can use a package like 'printing' to print the PDF
  // or use a package like 'open_file' to open and view the PDF
// }

// void _printIncomeStatement({
//   required double revenue,
//   required double cogs,
//   required double opex,
//   required double profit,
//   required BuildContext context,
// }) async {
  // Print the income statement PDF
  // await generateIncomeStatement(revenue, cogs, opex, profit);

  // Display a success message to the user
  // Fluttertoast.showToast(
  //   msg: 'Income statement printed successfully!',
  //   toastLength: Toast.LENGTH_SHORT,
  //   gravity: ToastGravity.CENTER,
  //   timeInSecForIosWeb: 1,
  //   backgroundColor: Colors.grey[800],
  //   textColor: Colors.white,
  //   fontSize: 16.0,
  // );
// }

  void sortItemsByDate() {
    widget.items.sort((a, b) {
      // Convert the date strings to DateTime objects
      DateTime dateA = DateTime.parse(a['date']);
      DateTime dateB = DateTime.parse(b['date']);

      // Sort in descending order (latest date first)
      return dateB.compareTo(dateA);
    });
  }

  // List<Map<String, dynamic>> get paginatedItems {
  //   sortItemsByDate(); // Sort the items before pagination
  //   final startIndex = (currentPage - 1) * itemsPerPage;
  //   return widget.items.skip(startIndex).take(itemsPerPage).toList();
  // }
  List<Map<String, dynamic>> get paginatedItems {
    sortItemsByDate(); // Sort the items before pagination
    List<Map<String, dynamic>> filtered = [];

    if (fromDate != null && toDate != null) {
      // If both fromDate and toDate are selected, filter by date range
      filtered = widget.items.where((item) {
        final itemDate = DateTime.parse(item['date']);
        return itemDate.isAfter(fromDate!) &&
            itemDate.isBefore(toDate!.add(Duration(days: 1)));
      }).toList();
    } else {
      // If no date range is selected, show all items
      filtered = widget.items;
    }

    final startIndex = (currentPage - 1) * itemsPerPage;
    return filtered.skip(startIndex).take(itemsPerPage).toList();
  }

  int get totalItems => widget.items.length;
  int get totalPages => (totalItems / itemsPerPage).ceil();

  List<Map<String, dynamic>> get filteredItems {
    if (_searchText.isEmpty && fromDate == null && toDate == null) {
      return paginatedItems;
    } else {
      return widget.items.where((item) {
        // Filter based on item name search
        final bool itemNameMatches = item['description']
            .toLowerCase()
            .contains(_searchText.toLowerCase());

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
    for (var item in widget.items) {
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
      for (var item in widget.items) {
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

  double getTotalCOGS() {
    if (_searchText.isEmpty && fromDate == null && toDate == null) {
      // If nothing is filtered, return the total COGS from the original items list
      double totalCOGS = 0;
      for (var item in widget.items) {
        totalCOGS += item['cost'] * item['quantity'];
      }
      return totalCOGS;
    } else {
      // If there are filters, calculate the total COGS from the filtered items list
      double totalCOGS = 0;
      for (var item in filteredItems) {
        totalCOGS += item['cost'] * item['quantity'];
      }
      return totalCOGS;
    }
  }

  void _printSalesReport({
    required bool shouldPrintReport,
    required List<Map<String, dynamic>> filteredItems,
    required double totalSales,
    required DateTime? fromDate,
    required DateTime? toDate,
    required BuildContext context,
  }) async {
    if (fromDate == null || toDate == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Date Range"),
            content: Text(
                "Please select a valid date range to generate the report."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    if (shouldPrintReport) {
      Fluttertoast.showToast(
        msg: 'Sales report is being printed...',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
        fontSize: 16.0,
      );

      await Future.delayed(Duration(seconds: 2));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomSalesReportModal(
            attendantName: 'John Doe',
            cartItems: filteredItems,
            total: totalSales,
            startDate: fromDate,
            endDate: toDate,
          ),
        ),
      );

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
    for (var item in widget.items) {
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
              widget.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard(
                'Revenue',
                // '₦${getTotalSales().toStringAsFixed(2)}',
                '₦200',

                Icons.trending_up, // Updated icon
                Colors.blue,
              ),
              SizedBox(width: 16),
              _buildStatCard(
                'COGS',
                // getTotalCOGS(),
                '₦400',

                Icons.receipt,
                Colors.orange,
              ),
              SizedBox(width: 16),
              _buildStatCard(
                'Opex',
                // '₦${getTotalSales().toStringAsFixed(2)}',
                '₦500',

                Icons.money_off, // Updated icon
                Colors.green,
              ),
              _buildStatCard(
                'Profit',
                // getProductsSoldToday(),
                '₦900',

                Icons.assignment, // Updated icon
                Color.fromARGB(255, 133, 50, 249),
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
              DataColumn(label: Text('Item Name')),
              DataColumn(label: Text('Qty')),
              DataColumn(label: Text(' Cost')),
              // DataColumn(label: Text('Status')),
              DataColumn(label: Text('Sales Price')),
            ],
            rows: filteredItems
                .map(
                  (item) => DataRow(
                    cells: [
                      DataCell(Text(item['transactionId'])),
                      DataCell(Text(item['date'])),
                      DataCell(Text(item['description'])),
                      DataCell(Text(item['exp'])),
                      DataCell(Text(item['amount'].toStringAsFixed(2))),
                      // DataCell(Text(item['vendor'])),
                      DataCell(Text(item['pMethod'])),
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
                onPressed: () {
                  // final revenue = 700; // Replace with your logic to calculate revenue
                  // final cogs = 800 // Replace with your logic to calculate COGS

                  // Placeholder values for opex and profit
                  final opex = 500.0;
                  final profit = 1000.0;

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      if (fromDate != null && toDate != null) {
                        // Both fromDate and toDate are not null, so use them
                        final filteredData = filteredItems.where((item) {
                          final itemDate = DateTime.parse(item['date']);
                          return itemDate.isAfter(fromDate!) &&
                              itemDate.isBefore(toDate!.add(Duration(days: 1)));
                        }).toList();

                        return ProfitAndLossStatementModal(
                          revenue: 900,
                          cogs: 300,
                          items: filteredData,
                          profit: profit,
                          fromDate: fromDate!,
                          toDate: toDate!,
                        );
                      } else {
                        // Either fromDate or toDate is null, show an error dialog or allow the user to select dates
                        return AlertDialog(
                          title: Text("Date Error"),
                          content: Text("Please select valid date range."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      }
                    },
                  );
                },
                child: const Text('Print Income Statement'),
              ),

              ElevatedButton(
                onPressed: () => _printSalesReport(
                  shouldPrintReport: true, // or false based on your logic
                  filteredItems:
                      filteredItems, // provide the filtered items list
                  totalSales: getTotalSales(), // provide the total sales
                  fromDate: fromDate!, // Non-null assertion here
                  toDate: toDate!, // Non-null assertion here
                  context: context,
                ),
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
