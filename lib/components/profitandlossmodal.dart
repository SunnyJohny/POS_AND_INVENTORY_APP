import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:io';
import 'dart:math';

class ProfitAndLossStatementModal extends StatelessWidget {
 final double revenue;
  final double cogs;
  final List<Map<String, dynamic>> items;
  final double profit;
  final DateTime fromDate;
  final DateTime toDate;

  ProfitAndLossStatementModal({
    required this.revenue,
    required this.cogs,
    required this.profit,
    required this.items,
    required this.fromDate,
    required this.toDate,
  });

  @override
  Widget build(BuildContext context) {
    final statementDate = DateTime.now();
    final statementNumber = generateStatementNumber();

    // Create a map to store category-wise totals
    final Map<String, double> categoryTotals = {};

    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          width: 400,
          padding: EdgeInsets.all(40),
          child: Container(
            padding: EdgeInsets.all(40),
            color: Colors.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                Text(
                  'Profit and Loss Statement',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Statement Number: ${statementNumber}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Statement Date: ${DateFormat('MM/dd/yyyy').format(statementDate)}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 16),
                DataTable(
                  columns: [
                    DataColumn(label: Text('Expense ID')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Expense')),
                    DataColumn(label: Text('Amount')),
                    DataColumn(label: Text('Category')),

                    // DataColumn(label: Text('Vendor')),
                    // DataColumn(label: Text('Payment Method')),
                  ],
                  rows: items
                      .map(
                        (item) {
                          // Calculate category-wise totals
                          final category = item['category'] ?? 'Other';
                          final amount = item['amount'] as double;
                          categoryTotals.update(
                            category,
                            (value) => value + amount,
                            ifAbsent: () => amount,
                          );

                          return DataRow(
                            cells: [
                              DataCell(Text(item['transactionId'])),
                              DataCell(Text(item['date'])),
                              DataCell(Text(item['exp'])),
                              DataCell(Text('₦${amount.toStringAsFixed(2)}')),
                              DataCell(Text(item['category'])),

                              // DataCell(Text(item['vendor'])),
                              // DataCell(Text(item['pMethod'])),
                            ],
                          );
                        },
                      )
                      .toList(),
                ),
                SizedBox(height: 10),
                // Display category-wise totals
                ...categoryTotals.entries.map(
                  (entry) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${entry.key} Total:', style: TextStyle(fontSize: 16)),
                      Text('₦${entry.value.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Revenue:', style: TextStyle(fontSize: 16)),
                        Text('Cost of Goods Sold (COGS):', style: TextStyle(fontSize: 16)),
                        Text('Operating Expenses:', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('\₦${revenue.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
                        Text('\₦${cogs.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
                        Text(
                          '\₦${categoryTotals.values.reduce((a, b) => a + b).toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Profit:', style: TextStyle(fontSize: 16)),
                    Text('\₦${profit.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Your code for saving and printing the PDF goes here
                      },
                      child: Text('Print & Save PDF'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> savePdf() async {
    final pdf = pw.Document();

    final now = DateTime.now();
    final statementNumber = generateStatementNumber();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Container(
              padding: pw.EdgeInsets.all(16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Revenue:',
                              style: pw.TextStyle(fontSize: 16)),
                          pw.Text('Cost of Goods Sold (COGS):',
                              style: pw.TextStyle(fontSize: 16)),
                          pw.Text('Operating Expenses:',
                              style: pw.TextStyle(fontSize: 16)),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text('\₦${revenue.toStringAsFixed(2)}',
                              style: pw.TextStyle(fontSize: 16)),
                          pw.Text('\₦${cogs.toStringAsFixed(2)}',
                              style: pw.TextStyle(fontSize: 16)),
                          pw.Text(
                              '\₦200',
                              style: pw.TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                  pw.Divider(),
                  pw.SizedBox(height: 10),
                  pw.Text('Profit:',
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('\₦${profit.toStringAsFixed(2)}',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                  pw.Divider(),
                  pw.Text(
                    'Profit and Loss Statement',
                    style: pw.TextStyle(
                        fontSize: 20, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Statement Date: ${DateFormat('MM/dd/yyyy').format(now)}',
                    style: pw.TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/profit_and_loss_statement.pdf');
    await file.writeAsBytes(await pdf.save());
  }

  Future<void> printPdf() async {
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/profit_and_loss_statement.pdf');
    final bytes = await file.readAsBytes();

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => bytes,
    );
  }

  String generateStatementNumber() {
    final random = Random();
    final letter1 = String.fromCharCode(random.nextInt(26) + 65);
    final letter2 = String.fromCharCode(random.nextInt(26) + 65);
    final number = random.nextInt(900000) + 100000;
    return '$letter1$letter2-$number';
  }
}






// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'dart:typed_data';
// import 'package:pdf/pdf.dart';
// import 'package:printing/printing.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:my_desktop_app/screens/report/profit_And_loss_dashboard.dart';
// import 'package:my_desktop_app/screens/report/profit_And_loss_dashboard.dart';

// import 'dart:io';
// import 'dart:math';

// class ProfitAndLossStatementModal extends StatelessWidget {
//   final double revenue;
//   final double cogs;
//   final List<double> operatingExpenses;
//   final double profit;
//   DateTime? fromDate;
//   DateTime? toDate;
//   int currentPage = 1;
//   int itemsPerPage = 5;

//   ProfitAndLossStatementModal({
//     required this.revenue,
//     required this.cogs,
//     required this.operatingExpenses,
//     required this.profit,
//   });

//   List<Map<String, dynamic>> items = [
//     {
//       'sn': '1',
//       'id': '1', // Item ID or Number
//       'transactionId': 'TRX001',
//       'date': '2023-07-15',
//       'itemname': 'Phone',
//       'customer': 'John Doe',
//       'quantity': 5,
//       'cost': 50.5,

//       'payment': 'Cash',
//       'amount': 500.0,
//       'attendant': 'Jane Smith',
//       'status': 'Completed',
//     },
//     {
//       'sn': '2',
//       'id': '2', // Item ID or Number
//       'transactionId': 'TRX002',
//       'date': '${DateTime.now().toString().split(' ')[0]}',
//       'itemname': 'Cream',
//       'customer': 'Alice Johnson',
//       'quantity': 6,
//       'cost': 50,
//       'amount': 250.0,
//       'attendant': 'John Smith',
//       'status': 'Completed',
//     },
//   ];

//   void sortItemsByDate() {
//     items.sort((a, b) {
//       // Convert the date strings to DateTime objects
//       DateTime dateA = DateTime.parse(a['date']);
//       DateTime dateB = DateTime.parse(b['date']);

//       // Sort in descending order (latest date first)
//       return dateB.compareTo(dateA);
//     });
//   }

//   List<Map<String, dynamic>> get paginatedItems {
//     sortItemsByDate(); // Sort the items before pagination
//     final startIndex = (currentPage - 1) * itemsPerPage;
//     return items.skip(startIndex).take(itemsPerPage).toList();
//   }

//   int get totalItems => items.length;
//   int get totalPages => (totalItems / itemsPerPage).ceil();
//   List<Map<String, dynamic>> get filteredItems {
//     if (_searchText.isEmpty && fromDate == null && toDate == null) {
//       return paginatedItems;
//     } else {
//       return items.where((item) {
//         // Filter based on item name search
//         final bool itemNameMatches =
//             item['itemname'].toLowerCase().contains(_searchText.toLowerCase());

//         // Filter based on date range selection
//         final bool isDateInRange = (fromDate == null ||
//                 (item['date'] != null &&
//                     DateTime.parse(item['date']).isAtSameMomentAs(fromDate!)) ||
//                 (item['date'] != null &&
//                     DateTime.parse(item['date']).isAfter(fromDate!))) &&
//             (toDate == null ||
//                 (item['date'] != null &&
//                     DateTime.parse(item['date']).isAtSameMomentAs(toDate!)) ||
//                 (item['date'] != null &&
//                     DateTime.parse(item['date'])
//                         .isBefore(toDate!.add(Duration(days: 1)))));

//         // Return true if item name and date range both match
//         return itemNameMatches && isDateInRange;
//       }).toList();
//     }
//   }

//   String _searchText = '';

//   @override
//   Widget build(BuildContext context) {
//     final statementDate = DateTime.now();
//     final statementNumber = generateStatementNumber();

//     return Material(
//       color: Colors.white,
//       child: Container(
//         width: 400,
//         padding: EdgeInsets.all(40),
//         child: Container(
//           padding: EdgeInsets.all(40),
//           color: Colors.green,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 20),
//               Divider(),
//               SizedBox(height: 20),
//               Text(
//                 'Profit and Loss Statement',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 'Statement Number: ${statementNumber}',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 'Statement Date: ${DateFormat('MM/dd/yyyy').format(statementDate)}',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 20),
//               Divider(),
//               SizedBox(height: 16),
//               DataTable(
//                 columns: [
//                   DataColumn(label: Text('Transaction ID')),
//                   DataColumn(label: Text('Date')),

//                   DataColumn(label: Text('Item Name')),
//                   DataColumn(label: Text('Qty')),
//                   DataColumn(label: Text(' Cost')),
//                   // DataColumn(label: Text('Status')),
//                   DataColumn(label: Text('Sales Price')),
//                 ],
//                 rows: filteredItems
//                     .map(
//                       (item) => DataRow(
//                         cells: [
//                           DataCell(Text(item['transactionId'])),
//                           DataCell(Text(item['date'])),

//                           DataCell(Text(item['itemname'])),
//                           DataCell(Text(item['quantity'].toString())),
//                           // DataCell(Text('₦${item['cost'].toStringAsFixed(2)}')),
//                           DataCell(Text(
//                               '₦${(item['cost'] * item['quantity']).toStringAsFixed(2)}')),

//                           DataCell(
//                               Text('₦${item['amount'].toStringAsFixed(2)}')),

//                           // DataCell(Text(item['status'])),
//                         ],
//                       ),
//                     )
//                     .toList(),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Revenue:',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       Text(
//                         'Cost of Goods Sold (COGS):',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       Text(
//                         'Operating Expenses:',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         '\₦${revenue.toStringAsFixed(2)}',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       Text(
//                         '\₦${cogs.toStringAsFixed(2)}',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       Text(
//                         '\₦${operatingExpenses.reduce((a, b) => a + b).toStringAsFixed(2)}',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               Divider(),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Profit:',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   Text(
//                     '\₦${profit.toStringAsFixed(2)}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Divider(),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () async {
//                       Fluttertoast.showToast(
//                         msg: 'Printing and saving in progress...',
//                         toastLength: Toast.LENGTH_SHORT,
//                         gravity: ToastGravity.CENTER,
//                         timeInSecForIosWeb: 1,
//                         backgroundColor: Colors.grey[800],
//                         textColor: Colors.white,
//                         fontSize: 16.0,
//                       );
//                       await savePdf();
//                       await printPdf();
//                     },
//                     child: Text('Print & Save PDF'),
//                   ),
//                   SizedBox(width: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text('Close'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> savePdf() async {
//     final pdf = pw.Document();

//     final now = DateTime.now();
//     final statementNumber = generateStatementNumber();

//     pdf.addPage(
//       pw.MultiPage(
//         build: (pw.Context context) {
//           return [
//             pw.Container(
//               padding: pw.EdgeInsets.all(50),
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.SizedBox(height: 20),
//                   pw.Divider(),
//                   pw.Text(
//                     'Profit and Loss Statement',
//                     style: pw.TextStyle(
//                         fontSize: 20, fontWeight: pw.FontWeight.bold),
//                   ),
//                   pw.Text(
//                     'Profit and Loss Statement',
//                     style: pw.TextStyle(
//                         fontSize: 20, fontWeight: pw.FontWeight.bold),
//                   ),
//                   pw.Text(
//                     'Statement Number: ${statementNumber}',
//                     style: pw.TextStyle(fontSize: 16),
//                   ),
//                   pw.SizedBox(height: 10),
//                   pw.Text(
//                     'Statement Date: ${DateFormat('MM/dd/yyyy').format(now)}',
//                     style: pw.TextStyle(fontSize: 16),
//                   ),
//                   pw.SizedBox(height: 10),
//                   pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                     children: [
//                       pw.Column(
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           pw.Text('Revenue:',
//                               style: pw.TextStyle(fontSize: 16)),
//                           pw.Text('Cost of Goods Sold (COGS):',
//                               style: pw.TextStyle(fontSize: 16)),
//                           pw.Text('Operating Expenses:',
//                               style: pw.TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       pw.Column(
//                         crossAxisAlignment: pw.CrossAxisAlignment.end,
//                         children: [
//                           pw.Text('\₦${revenue.toStringAsFixed(2)}',
//                               style: pw.TextStyle(fontSize: 16)),
//                           pw.Text('\₦${cogs.toStringAsFixed(2)}',
//                               style: pw.TextStyle(fontSize: 16)),
//                           pw.Text(
//                               '\₦${operatingExpenses.reduce((a, b) => a + b).toStringAsFixed(2)}',
//                               style: pw.TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                     ],
//                   ),
//                   pw.SizedBox(height: 20),
//                   pw.Divider(),
//                   pw.SizedBox(height: 10),
//                   pw.Text('Profit:',
//                       style: pw.TextStyle(
//                           fontSize: 16, fontWeight: pw.FontWeight.bold)),
//                   pw.SizedBox(height: 10),
//                   pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                     children: [
//                       pw.Text('\₦${profit.toStringAsFixed(2)}',
//                           style: pw.TextStyle(
//                               fontSize: 16, fontWeight: pw.FontWeight.bold)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ];
//         },
//       ),
//     );

//     final output = await getTemporaryDirectory();
//     final file = File('${output.path}/profit_and_loss_statement.pdf');
//     await file.writeAsBytes(await pdf.save());
//   }

//   Future<void> printPdf() async {
//     final output = await getTemporaryDirectory();
//     final file = File('${output.path}/profit_and_loss_statement.pdf');
//     final bytes = await file.readAsBytes();

//     await Printing.layoutPdf(
//       onLayout: (PdfPageFormat format) async => bytes,
//     );
//   }

//   String generateStatementNumber() {
//     final random = Random();
//     final letter1 = String.fromCharCode(random.nextInt(26) + 65);
//     final letter2 = String.fromCharCode(random.nextInt(26) + 65);
//     final number = random.nextInt(900000) + 100000;
//     return '$letter1$letter2-$number';
//   }
// }
