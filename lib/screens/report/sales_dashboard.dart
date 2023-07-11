import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  List<Map<String, String>> items = [
    {
      'sn': '1',
      'transactionId': 'TRX001',
      'date': '2023-07-01',
      'itemname': 'Phone',

      'customer': 'John Doe',
      
      'quantity': '5',
      'payment': 'Cash',
      'amount': '₦500',
      'attendant': 'Jane Smith',
      'status': 'Completed',
    },
    {
      'sn': '2',
      'transactionId': 'TRX002',
      'date': '2023-07-01',
      'itemname': 'Cream',

      'customer': 'Alice Johnson',
      'quantity': '6',

      'payment': 'Card',
      'amount': '₦250',
      'attendant': 'John Smith',
      'status': 'Completed',
    },
    {
      'sn': '3',
      'transactionId': 'TRX003',
      'date': '2023-07-02',
      'itemname': 'Paracetamol',

      'customer': 'Bob Williams',
      'quantity': '4',

      'payment': 'Cash',
      'amount': '₦700',
      'attendant': 'Jane Doe',
      'status': 'Pending',
    },
    {
      'sn': '4',
      'transactionId': 'TRX004',
      'date': '2023-07-02',
      'itemname': 'Perfume',

      'customer': 'Eve Brown',
      'quantity': '5',

      'payment': 'Card',
      'amount': '₦450',
      'attendant': 'John Doe',
      'status': 'Completed',
    },
    {
      'sn': '5',
      'transactionId': 'TRX005',
      


      'date': '2023-07-03',
      'itemname': 'Liquid Soap',

      'customer': 'Grace Davis',
      'quantity': '5',

      'payment': 'Cash',
      'amount': '₦800',
      'attendant': 'Jane Smith',
      'status': 'Pending',
    },
    {
      'sn': '6',
      'transactionId': 'TRX006',
      'date': '2023-07-03',
      'itemname': 'Bag',

      'customer': 'Henry Wilson',
      'quantity': '1',

      'payment': 'Card',
      'amount': '₦350',
      'attendant': 'John Smith',
      'status': 'Completed',
    },
    {
      'sn': '7',
      'transactionId': 'TRX007',
      'date': '2023-07-03',
      'itemname': 'Book',

      'customer': 'Ivy Thomas',
      'quantity': '2',

      'payment': 'Cash',
      'amount': '₦650',
      'attendant': 'Jane Doe',
      'status': 'Pending',
    },
  ];

  List<Map<String, String>> get paginatedItems {
    final startIndex = (currentPage - 1) * itemsPerPage;
    return items.skip(startIndex).take(itemsPerPage).toList();
  }

  int get totalItems => items.length;
  int get totalPages => (totalItems / itemsPerPage).ceil();

  List<Map<String, String>> get filteredItems {
    if (_searchText.isEmpty) {
      return paginatedItems;
    } else {
      return paginatedItems.where((item) {
        return item['transactionId']!
            .toLowerCase()
            .contains(_searchText.toLowerCase());
      }).toList();
    }
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
                '₦500',
                Icons.attach_money,
                Colors.blue,
              ),
              SizedBox(width: 16),
              _buildStatCard(
                'Total Sales',
                '₦10,000',
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
                ' Products Sold Today',
                '5',
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
                              ? fromDate.toString().split(' ')[0]
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
                              ? toDate.toString().split(' ')[0]
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
              // DataColumn(label: Text('Item')),

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
                      DataCell(Text(item['transactionId']!)),
                      DataCell(Text(item['date']!)),
                      // DataCell(Text(item['itemname']!)),

                      DataCell(Text(item['attendant']!)),
                      DataCell(Text(item['itemname']!)),
                      DataCell(Text(item['quantity']!)),

                      DataCell(Text(item['amount']!)),
                      DataCell(Text(item['payment']!)),
                      DataCell(Text(item['status']!)),
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
      String title, String value, IconData icon, Color color) {
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
                  value,
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
