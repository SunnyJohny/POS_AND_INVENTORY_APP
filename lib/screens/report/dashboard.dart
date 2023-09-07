import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentPage = 1;
  int itemsPerPage = 5;

  List<Map<String, String>> items = [
    {
      'sn': '1',
      'name': 'Product 1',
      'category': 'Category 1',
      'price': '\$50',
      'quantity': '5',
      'value': '\$50',
    },
    {
      'sn': '2',
      'name': 'Product 2',
      'category': 'Category 2',
      'price': '\$50',
      'quantity': '3',
      'value': '\$50',
    },
    {
      'sn': '3',
      'name': 'Product 3',
      'category': 'Category 1',
      'price': '\$50',
      'quantity': '7',
      'value': '\$50',
    },
    {
      'sn': '4',
      'name': 'Product 4',
      'category': 'Category 2',
      'price': '\$25',
      'quantity': '2',
      'value': '\$50',
    },
    {
      'sn': '5',
      'name': 'Product 5',
      'category': 'Category 1',
      'price': '\$12',
      'quantity': '0',
      'value': '\$48',
    },
    {
      'sn': '6',
      'name': 'Product 6',
      'category': 'Category 2',
      'price': '\$30',
      'quantity': '6',
      'value': '\$180',
    },
    {
      'sn': '7',
      'name': 'Product 7',
      'category': 'Category 1',
      'price': '\$18',
      'quantity': '3',
      'value': '\$54',
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
        return item['name']!.toLowerCase().contains(_searchText.toLowerCase());
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
          padding: EdgeInsets.only(left: 16), // Added bottom padding for the inventory stat text
          child: Text(
            'Inventory Stats',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard(
                  'Total Products', totalProducts().toString(), Colors.blue),
              SizedBox(width: 16),
              _buildStatCard('Total Store Value', totalStoreValue().toString(),
                  Colors.green),
              SizedBox(width: 16),
              _buildStatCard(
                  'Out Of Stock', outOfStockItems().toString(), Colors.red),
              SizedBox(width: 16),
              _buildStatCard(
                  'All Categories', allCategories().toString(), Colors.orange),
            ],
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Row(
            children: [
               Padding(
          padding: EdgeInsets.only(left: 16), // Added bottom padding for the inventory stat text
          child: Text(
            'Inventory Ite',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
              SizedBox(width: 16),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          DataTable(
            columns: [
              DataColumn(label: Text('S/n')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Quantity')),
              DataColumn(label: Text('Value')),
              DataColumn(label: Text('Action')),
            ],
            rows: filteredItems
                .map(
                  (item) => DataRow(
                    cells: [
                      DataCell(Text(item['sn']!)),
                      DataCell(Text(item['name']!)),
                      DataCell(Text(item['category']!)),
                      DataCell(Text(item['price']!)),
                      DataCell(Text(item['quantity']!)),
                      DataCell(Text(item['value']!)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Handle view action
                              },
                              icon: Icon(Icons.remove_red_eye),
                            ),
                            IconButton(
                              onPressed: () {
                                // Handle edit action
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                // Handle delete action
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
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
        margin: EdgeInsets.only(left: 8), // Add left margin here for Previous button
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
        margin: EdgeInsets.only(right: 8), // Add right margin here for Next button
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

  Widget _buildStatCard(String title, String value, Color color) {
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
            Text(
              value,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  int totalProducts() {
    return totalItems;
  }

  int totalStoreValue() {
    int value = 0;
    for (var item in items) {
      value += int.parse(item['value']!.replaceAll('\$', ''));
    }
    return value;
  }

  int outOfStockItems() {
    int count = 0;
    for (var item in items) {
      int quantity = int.parse(item['quantity']!);
      if (quantity == 0) {
        count++;
      }
    }
    return count;
  }

  int allCategories() {
    Set<String> categories = Set();
    for (var item in items) {
      categories.add(item['category']!);
    }
    return categories.length;
  }
}
