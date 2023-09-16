// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:my_desktop_app/components/custom_sales_report_modal.dart';

// import 'package:my_desktop_app/components/profitandlossmodal.dart';

// import 'package:file_picker/file_picker.dart';

// import 'dart:io';
// import 'dart:math';

// class ExpenseDashboard extends StatefulWidget {
//   @override
//   _ExpenseDashboardState createState() => _ExpenseDashboardState();
// }

// class _ExpenseDashboardState extends State<ExpenseDashboard> {
//   // Function to generate a random 5-character alphanumeric Ref No
// // Function to generate a random 5-character alphanumeric Ref No
//   static String _generateRandomRefNo() {
//     const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
//     final Random random = Random.secure();
//     return String.fromCharCodes(Iterable.generate(
//         5, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
//   }

//   List<Map<String, dynamic>> get filteredItems {
//     if (fromDate == null && toDate == null) {
//       return items;
//     }

//     return items.where((item) {
//       final DateTime itemDate = DateTime.parse(item['date']);
//       return (fromDate != null && toDate != null) &&
//           itemDate.isAfter(fromDate!.subtract(Duration(days: 1))) &&
//           itemDate.isBefore(toDate!.add(Duration(days: 1)));
//     }).toList();
//   }




//   int currentPage = 1;
//   int itemsPerPage = 5;
// DateTime? fromDate;
// DateTime? toDate;

// Future<void> _selectFromDate(BuildContext context) async {
//   final DateTime? selectedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2100),
//   );

//   if (selectedDate != null) {
//     setState(() {
//       fromDate = selectedDate;
//     });
//   }
// }

//  Future<void> _selectToDate(BuildContext context) async {
//   final DateTime? selectedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2100),
//   );

//   if (selectedDate != null) {
//     setState(() {
//       toDate = selectedDate;
//     });
//   }
// }

//   List<Map<String, dynamic>> items = [
//     {
//       'transactionId': 'TRX001',
//       'date': '2023-07-15',
//       'description': 'Expense 1',
//       'exp': 'Office Rent', // Updated to Office Rent
//       'category': 'Operating Expenses', // Added category field
//       'amount': 500.0,
//       'vendor': 'Vendor 1',
//       'pMethod': 'Cash',
//     },
//     {
//       'transactionId': 'TRX002',
//       'date': '2023-07-15',
//       'description': 'Expense 2',
//       'exp': 'Workshops', // Updated to Workshops
//       'category': 'Operating Expenses', // Added category field
//       'amount': 250.0,
//       'vendor': 'Vendor 2',
//       'pMethod': 'Credit Card',
//     },
//     {
//       'transactionId': 'TRX003',
//       'date': '2023-07-15',
//       'description': 'Expense 3',
//       'exp': 'Workshops', // Updated to Workshops
//       'category': 'Operating Expenses', // Added category field
//       'amount': 450.0,
//       'vendor': 'Vendor 2',
//       'pMethod': 'Credit Card',
//     },
//     {
//       'transactionId': 'TRX004',
//       'date': '2023-07-15',
//       'description': 'Expense 4',
//       'exp': 'Equipment Repairs', // Updated to Equipment Repairs
//       'category': 'Cost of Goods Sold', // Added category field
//       'amount': 750.0,
//       'vendor': 'Vendor 3', // Update vendor if needed
//       'pMethod': 'Cash',
//     },
//     {
//       'transactionId': 'TRX005',
//       'date': '2023-07-16',
//       'description': 'Expense 5',
//       'exp': 'Advertising',
//       'category': 'Operating Expenses',
//       'amount': 300.0,
//       'vendor': 'Vendor 4',
//       'pMethod': 'Credit Card',
//     },
//     {
//       'transactionId': 'TRX006',
//       'date': '2023-07-16',
//       'description': 'Expense 6',
//       'exp': 'Office Supplies',
//       'category': 'Operating Expenses',
//       'amount': 150.0,
//       'vendor': 'Vendor 5',
//       'pMethod': 'Cash',
//     },
//     {
//       'transactionId': 'TRX007',
//       'date': '2023-07-17',
//       'description': 'Expense 7',
//       'exp': 'Rent/Lease',
//       'category': 'Operating Expenses',
//       'amount': 900.0,
//       'vendor': 'Vendor 6',
//       'pMethod': 'Credit Card',
//     },
//     {
//       'transactionId': 'TRX008',
//       'date': '2023-07-17',
//       'description': 'Expense 8',
//       'exp': 'Rent/Lease',
//       'category': 'Operating Expenses',
//       'amount': 2.20,
//       'vendor': 'Vendor 6',
//       'pMethod': 'Credit Card',
//     },
//     {
//       'transactionId': 'TRX008',
//       'date': '2023-07-17',
//       'description': 'Expense 8',
//       'exp': 'Rent/Lease',
//       'category': 'Operating Expenses',
//       'amount': 350.40,
//       'vendor': 'Vendor 6',
//       'pMethod': 'Credit Card',
//     },
//     {
//       'transactionId': 'TRX008',
//       'date': '2023-07-03',
//       'description': 'Expense 8',
//       'exp': 'Rent/Lease',
//       'category': 'Operating Expenses',
//       'amount': 260.50,
//       'vendor': 'Vendor 6',
//       'pMethod': 'Credit Card',
//     },
//      {
//       'transactionId': 'TRX008',
//       'date': '2023-07-01',
//       'description': 'Expense 8',
//       'exp': 'Rent/Lease',
//       'category': 'Operating Expenses',
//       'amount': 260.50,
//       'vendor': 'Vendor 6',
//       'pMethod': 'Credit Card',
//     },
//      {
//       'transactionId': 'TRX008',
//       'date': '2023-07-10',
//       'description': 'Expense 8',
//       'exp': 'Rent/Lease',
//       'category': 'Operating Expenses',
//       'amount': 260.90,
//       'vendor': 'Vendor 6',
//       'pMethod': 'Credit Card',
//     },
//      {
//       'transactionId': 'TRX008',
//       'date': '2023-07-17',
//       'description': 'Expense 8',
//       'exp': 'Rent/Lease',
//       'category': 'Operating Expenses',
//       'amount': 960.90,
//       'vendor': 'Vendor 6',
//       'pMethod': 'Credit Card',
//     },



//     // Add more items here...


//   ];

// // final List<Map<String, dynamic>> formattedItems = items.map((item) {
// //     // Modify the data structure here as needed
// //     return {
// //       'transactionId': item['transactionId'],
// //       'date': item['date'],
// //       'description': item['description'],
// //       'exp': item['exp'],
// //       'category': item['category'],
// //       'amount': item['amount'],
// //       'vendor': item['vendor'],
// //       'pMethod': item['pMethod'],
// //     };
// //   }).toList();

//     void sortItemsByDate() {
//     items.sort((a, b) {
//       // Convert the date strings to DateTime objects
//       DateTime dateA = DateTime.parse(a['date']);
//       DateTime dateB = DateTime.parse(b['date']);

//       // Sort in descending order (latest date first)
//       return dateB.compareTo(dateA);
//     });
//   }

//    List<Map<String, dynamic>> get paginatedItems {
//     sortItemsByDate(); // Sort the items before pagination
//     final startIndex = (currentPage - 1) * itemsPerPage;
//     return items.skip(startIndex).take(itemsPerPage).toList();
//   }


//   int get totalItems => items.length;
//   int get totalPages => (totalItems / itemsPerPage).ceil();

//   // List<Map<String, dynamic>> get filteredItems {
//   //   if (_searchText.isEmpty && fromDate == null && toDate == null) {
//   //     return paginatedItems;
//   //   } else {
//   //     return items.where((item) {
//   //       // Filter based on item name search
//   //       final bool itemNameMatches =
//   //           item['itemname'].toLowerCase().contains(_searchText.toLowerCase());

//   //       // Filter based on date range selection
//   //       final bool isDateInRange = (fromDate == null ||
//   //               (item['date'] != null &&
//   //                   DateTime.parse(item['date']).isAtSameMomentAs(fromDate!)) ||
//   //               (item['date'] != null &&
//   //                   DateTime.parse(item['date']).isAfter(fromDate!))) &&
//   //           (toDate == null ||
//   //               (item['date'] != null &&
//   //                   DateTime.parse(item['date']).isAtSameMomentAs(toDate!)) ||
//   //               (item['date'] != null &&
//   //                   DateTime.parse(item['date'])
//   //                       .isBefore(toDate!.add(Duration(days: 1)))));

//   //       // Return true if item name and date range both match
//   //       return itemNameMatches && isDateInRange;
//   //     }).toList();
//   //   }
//   // }

//   double getTodaySales() {
//     var now = DateTime.now();
//     var formattedDate = DateFormat('yyyy-MM-dd').format(now);

//     double totalSales = 0;
//     for (var item in items) {
//       if (item['date'] == formattedDate) {
//         totalSales += item['amount'];
//       }
//     }
//     return totalSales;
//   }

//   double getTotalSales() {
//     if (_searchText.isEmpty && fromDate == null && toDate == null) {
//       // If nothing is filtered, return the total sales from the original items list
//       double totalSales = 0;
//       for (var item in items) {
//         totalSales += item['amount'];
//       }
//       return totalSales;
//     } else {
//       // If there are filters, calculate the total sales from the filtered items list
//       double totalSales = 0;
//       for (var item in filteredItems) {
//         totalSales += item['amount'];
//       }
//       return totalSales;
//     }
//   }

//   double getTotalCOGS() {
//     if (_searchText.isEmpty && fromDate == null && toDate == null) {
//       // If nothing is filtered, return the total COGS from the original items list
//       double totalCOGS = 0;
//       for (var item in items) {
//         totalCOGS += 100;
//       }
//       return totalCOGS;
//     } else {
//       // If there are filters, calculate the total COGS from the filtered items list
//       double totalCOGS = 0;
//       for (var item in filteredItems) {
//         totalCOGS += 50;
//       }
//       return totalCOGS;
//     }
//   }

//   void _postExpense() {
//     print("Expense posted");
//   }

//   void _printSalesReport({
//     required bool shouldPrintReport,
//     required List<Map<String, dynamic>> filteredItems,
//     required double totalSales,
//     required DateTime? fromDate,
//     required DateTime? toDate,
//     required BuildContext context,
//   }) async {
//     if (fromDate == null || toDate == null) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Select Date Range"),
//             content: Text(
//                 "Please select a valid date range to generate the report."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Close the dialog
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     }

//     if (shouldPrintReport) {
//       Fluttertoast.showToast(
//         msg: 'Sales report is being printed...',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.grey[800],
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );

//       await Future.delayed(Duration(seconds: 2));

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CustomSalesReportModal(
//             attendantName: 'John Doe',
//             cartItems: filteredItems,
//             total: totalSales,
//             startDate: fromDate,
//             endDate: toDate,
//           ),
//         ),
//       );

//       Fluttertoast.showToast(
//         msg: 'Sales report printed successfully!',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.grey[800],
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     } else {
//       Fluttertoast.showToast(
//         msg: 'Sales report printing canceled!',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.grey[800],
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     }
//   }

//   int getProductsSoldToday() {
//     var now = DateTime.now();
//     var formattedDate = DateFormat('yyyy-MM-dd').format(now);

//     int productsSold = 0;
//     for (var item in items) {
//       if (item['date'] == formattedDate) {
//         productsSold += item['quantity'] as int;
//       }
//     }
//     return productsSold;
//   }

//   String _searchText = '';

//  @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 16),
//             child: Text(
//               'Expense Account',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//           ),
//           SizedBox(height: 16),
//           Row(
//             children: [
//               _buildStatCard(
//                 ' Total Expense',
//                 '₦${getTotalSales().toStringAsFixed(2)}',

//                 Icons.trending_up, // Updated icon
//                 Colors.blue,
//               ),
//               SizedBox(width: 16),
//               _buildStatCard(
//                 'Filtered Expenses',
//                 '₦${getTodaySales().toStringAsFixed(2)}',

//                 Icons.money_off, // Updated icon
//                 Colors.green,
//               ),
//               SizedBox(width: 16),
//               _buildStatCard(
//                 'COGS',
//                 getTotalCOGS(),
//                 Icons.receipt,
//                 Colors.orange,
//               ),
//               _buildStatCard(
//                 'OPex',
//                 getProductsSoldToday(),
//                 Icons.assignment, // Updated icon
//                 Colors.red,
//               ),
//             ],
//           ),
//            SizedBox(height: 16),
//           Divider(),
//             SizedBox(height: 16),
//           Divider(),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Sales By Time Period :  ',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 16),
//               Row(
//                 children: [
//                   Text('FROM: '),
//                   GestureDetector(
//                     onTap: () => _selectFromDate(context),
//                     child: Row(
//                       children: [
//                         Icon(Icons.calendar_today),
//                         SizedBox(width: 8),
//                         Text(
//                           fromDate != null
//                               ? DateFormat('dd-MM-yyyy').format(fromDate!)
//                               : 'Select Date',
//                           style:
//                               TextStyle(decoration: TextDecoration.underline),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 16),
//                   Text('TO: '),
//                   GestureDetector(
//                     onTap: () => _selectToDate(context),
//                     child: Row(
//                       children: [
//                         Icon(Icons.calendar_today),
//                         SizedBox(width: 8),
//                         Text(
//                           toDate != null
//                               ? DateFormat('dd-MM-yyyy').format(toDate!)
//                               : 'Select Date',
//                           style:
//                               TextStyle(decoration: TextDecoration.underline),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.topRight,
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.2,
//                     margin: EdgeInsets.only(top: 2, right: 2),
//                     child: TextField(
//                       onChanged: (value) {
//                         setState(() {
//                           _searchText = value;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Search Sales By Product',
//                         prefixIcon: Icon(Icons.search),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             "Today's (${DateFormat('dd-MM-yyyy').format(DateTime.now())}) Transactions",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 16),
//           // Updated DataTable with additional columns
//           DataTable(
//             columns: [
//               DataColumn(label: Text('Transaction ID')),
//               DataColumn(label: Text('Date')),
//               DataColumn(label: Text('Description')),
//               DataColumn(label: Text('Expense')),
//               DataColumn(label: Text('Amount')),
//               DataColumn(label: Text('Vendor')),
//               DataColumn(label: Text('P.Method')),
//             ],
//             rows: filteredItems
//                 .map(
//                   (item) => DataRow(
//                     cells: [
//                       DataCell(Text(item['transactionId'])),
//                       DataCell(Text(item['date'])),
//                       DataCell(Text(item['description'])),
//                       DataCell(Text(item['exp'])),
//                       DataCell(Text(item['amount'].toStringAsFixed(2))),
//                       DataCell(Text(item['vendor'])),
//                       DataCell(Text(item['pMethod'])),
//                     ],
//                   ),
//                 )
//                 .toList(),
//           ),

//           SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Flexible(
//                 flex: 1,
//                 child: Container(
//                   margin: EdgeInsets.only(left: 8),
//                   child: ElevatedButton(
//                     onPressed: currentPage > 1
//                         ? () {
//                             setState(() {
//                               currentPage--;
//                             });
//                           }
//                         : null,
//                     child: Text('Previous'),
//                   ),
//                 ),
//               ),
//               Text('Page $currentPage of $totalPages'),
//               // Add the "Print Sales Report" button
//               ElevatedButton(
//                 onPressed: () {
//                   final revenue = getTotalSales();
//                   final cogs = getTotalCOGS();
//                   final opex = 500.0;
//                   final profit = 1000.0;

//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return ProfitAndLossStatementModal(
//                         revenue: revenue,
//                         cogs: cogs,
//                         items: filteredItems,
//                         profit: profit,
//                         fromDate: fromDate!,
//                         toDate: toDate!,
//                       );
//                     },
//                   );
//                 },
//                 child: const Text('Print Income Statement'),
//               ),

//               ElevatedButton(
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: Text("Post Expense"),
//                         content: ExpenseFormWidget(),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: Text("Close"),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               print("Posted");
//                               Navigator.pop(context);
//                             },
//                             child: Text("Submit"),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 child: Text('Post Expense'),
//               ),

//               ElevatedButton(
//                 onPressed: () => _printSalesReport(
//                   shouldPrintReport: true,
//                   filteredItems: filteredItems,
//                   totalSales: getTotalSales(),
//                   fromDate: fromDate!,
//                   toDate: toDate!,
//                   context: context,
//                 ),
//                 child: const Text('Print Sales Report'),
//               ),
//               Flexible(
//                 flex: 1,
//                 child: Container(
//                   margin: EdgeInsets.only(right: 8),
//                   child: ElevatedButton(
//                     onPressed: currentPage < totalPages
//                         ? () {
//                             setState(() {
//                               currentPage++;
//                             });
//                           }
//                         : null,
//                     child: Text('Next'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//         ],
//       ),
//     );
//   }
//   Widget _buildStatCard(
//       String title, dynamic value, IconData icon, Color color) {
//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.all(16),
//         margin: EdgeInsets.symmetric(horizontal: 8),
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(fontSize: 16, color: Colors.white),
//             ),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '$value',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 Icon(
//                   icon,
//                   color: Colors.white,
//                   size: 24,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ExpenseFormWidget extends StatefulWidget {
//   @override
//   _ExpenseFormWidgetState createState() => _ExpenseFormWidgetState();
// }

// class _ExpenseFormWidgetState extends State<ExpenseFormWidget> {
//   final TextEditingController _dateController = TextEditingController(
//       text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
//   final TextEditingController _refNoController =
//       TextEditingController(text: _generateRandomRefNo());
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _expCatController = TextEditingController();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _vendorController = TextEditingController();
//   final TextEditingController _pMethodController = TextEditingController();
//   File? _receiptFile; // Field to store the selected file

//   // Function to generate a random 5-character alphanumeric Ref No
//   static String _generateRandomRefNo() {
//     const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
//     final Random random = Random.secure();
//     return String.fromCharCodes(Iterable.generate(
//         5, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
//   }

//   // Function to handle file selection
//   Future<void> _selectFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();

//     if (result != null) {
//       File file = File(result.files.single.path!);
//       setState(() {
//         _receiptFile = file;
//       });
//     } else {
//       // User canceled file selection
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextFormField(
//             controller: _dateController,
//             decoration: InputDecoration(labelText: 'Date'),
//           ),
//           TextFormField(
//             controller: _refNoController,
//             decoration: InputDecoration(labelText: 'Ref No'),
//           ),
//           TextFormField(
//             controller: _descriptionController,
//             decoration: InputDecoration(labelText: 'Description'),
//           ),
//           TextFormField(
//             controller: _expCatController,
//             decoration: InputDecoration(labelText: 'Exp Cat'),
//           ),
//           TextFormField(
//             controller: _amountController,
//             decoration: InputDecoration(labelText: 'Amount'),
//             keyboardType: TextInputType.number,
//           ),
//           TextFormField(
//             controller: _vendorController,
//             decoration: InputDecoration(labelText: 'Vendor'),
//           ),
//           TextFormField(
//             controller: _pMethodController,
//             decoration: InputDecoration(labelText: 'P.Method'),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: 16), // Add margin here
//             child: ElevatedButton(
//               onPressed: _selectFile, // Call the file selection function
//               child: Text('Upload Receipt'),
//             ),
//           ),
//           // Display the selected file name, if available
//           if (_receiptFile != null)
//             Text('Selected File: ${_receiptFile!.path}'),

//           Container(
//             margin: EdgeInsets.only(top: 16), // Add margin here
//             child: ElevatedButton(
//               onPressed: () {
//                 // Handle form submission here, including the selected file (_receiptFile)
//                 // ...
//               },
//               child: Text('Submit'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }






