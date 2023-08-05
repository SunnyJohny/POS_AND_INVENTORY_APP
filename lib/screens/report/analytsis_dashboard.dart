import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
// import 'chart_widget.dart'; // Import the ChartWidget class from the chart_widget.dart file

class AnalysisDashboard extends StatefulWidget {
  @override
  _AnalysisDashboardState createState() => _AnalysisDashboardState();
}

class _AnalysisDashboardState extends State<AnalysisDashboard> {
  DateTime? fromDate;
  DateTime? toDate;
  bool showChart = false; // Add this variable to control chart visibility
  bool showProductSoldChartWidget = false;

  List<Map<String, dynamic>> items = [
    {
      'transactionId': 'TRX001',
      'date': '2023-05-01',
      'attendant': 'John Doe',
      'itemname': 'Product A',
      'quantity': 5,
      'amount': 250.0,
      'payment': 'Cash',
      'status': 'Completed',
    },
    {
      'transactionId': 'TRX001',
      'date': '2023-09-01',
      'attendant': 'John Doe',
      'itemname': 'Product A',
      'quantity': 5,
      'amount': 250.0,
      'payment': 'Cash',
      'status': 'Completed',
    },
    {
      'transactionId': 'TRX001',
      'date': '2023-10-01',
      'attendant': 'John Doe',
      'itemname': 'Product A',
      'quantity': 5,
      'amount': 250.0,
      'payment': 'Cash',
      'status': 'Completed',
    },
    {
      'transactionId': 'TRX001',
      'date': '2023-11-01',
      'attendant': 'John Doe',
      'itemname': 'Product A',
      'quantity': 5,
      'amount': 250.0,
      'payment': 'Cash',
      'status': 'Completed',
    },
    {
      'transactionId': 'TRX001',
      'date': '2023-01-01',
      'attendant': 'John Doe',
      'itemname': 'Product A',
      'quantity': 5,
      'amount': 250.0,
      'payment': 'Cash',
      'status': 'Completed',
    },
    {
      'transactionId': 'TRX001',
      'date': '2023-02-01',
      'attendant': 'John Doe',
      'itemname': 'Product A',
      'quantity': 5,
      'amount': 650.0,
      'payment': 'Cash',
      'status': 'Completed',
    },
    {
      'transactionId': 'TRX001',
      'date': '2023-03-01',
      'attendant': 'John Doe',
      'itemname': 'Product A',
      'quantity': 5,
      'amount': 550.0,
      'payment': 'Cash',
      'status': 'Completed',
    },
    {
      'transactionId': 'TRX001',
      'date': '2023-03-01',
      'attendant': 'John Doe',
      'itemname': 'Product A',
      'quantity': 5,
      'amount': 250.0,
      'payment': 'Cash',
      'status': 'Completed',
    },
    {
      'transactionId': 'TRX001',
      'date': '2023-06-01',
      'attendant': 'John Doe',
      'itemname': 'Product A',
      'quantity': 5,
      'amount': 250.0,
      'payment': 'Cash',
      'status': 'Completed',
    },
    {
      'transactionId': 'TRX001',
      'date': '2023-08-01',
      'attendant': 'John Doe',
      'itemname': 'Product A',
      'quantity': 5,
      'amount': 250.0,
      'payment': 'Cash',
      'status': 'Completed',
    },
    {
      'transactionId': 'TRX001',
      'date': '2023-04-01',
      'attendant': 'John Doe',
      'itemname': 'Product A',
      'quantity': 5,
      'amount': 250.0,
      'payment': 'Cash',
      'status': 'Completed',
    },
    {
      'transactionId': 'TRX002',
      'date': '2023-07-02',
      'attendant': 'Jane Smith',
      'itemname': 'Product B',
      'quantity': 3,
      'amount': 180.0,
      'payment': 'Credit Card',
      'status': 'Completed',
    },
    {
      'transactionId': 'TRX003',
      'date': '2023-07-03',
      'attendant': 'Mike Johnson',
      'itemname': 'Product C',
      'quantity': 8,
      'amount': 980.0,
      'payment': 'Cash',
      'status': 'Completed',
    },
    {
      'transactionId': 'TRX003',
      'date': '2023-07-03',
      'attendant': 'Mike Johnson',
      'itemname': 'Product C',
      'quantity': 8,
      'amount': 520.0,
      'payment': 'Cash',
      'status': 'Completed',
    },
    {
      'transactionId': 'TRX003',
      'date': '2023-12-03',
      'attendant': 'Mike Johnson',
      'itemname': 'Product C',
      'quantity': 8,
      'amount': 390.0,
      'payment': 'Cash',
      'status': 'Completed',
    },
    // Add more sales data entries here...
  ];

List<ProductSoldData> staticProductSoldData = [
  ProductSoldData(itemName: 'Product A', quantity: 50, salesTime: DateTime(2023, 7, 15)),
  ProductSoldData(itemName: 'Product B', quantity: 30, salesTime: DateTime(2023, 5, 16)),
  ProductSoldData(itemName: 'Product C', quantity: 20, salesTime: DateTime(2023, 1, 17)),
  // Add more data as needed...
];


  void sortItemsByDate() {
    items.sort((a, b) {
      DateTime dateA = DateTime.parse(a['date']);
      DateTime dateB = DateTime.parse(b['date']);
      return dateB.compareTo(dateA);
    });
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
    double totalSales = 0;
    for (var item in items) {
      totalSales += item['amount'];
    }
    return totalSales;
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

  // Calculate aggregate sales by summing up all sales values
  double getAggregateSales() {
    double aggregateSales = 0;
    for (var item in items) {
      aggregateSales += item['amount'];
    }
    return aggregateSales;
  }

  // Prepare monthly sales data
  List<Map<String, dynamic>> getMonthlySalesData() {
    // Assuming 'date' is in the format 'yyyy-MM-dd'
    Map<String, double> monthlySalesMap = {};
    for (var item in items) {
      DateTime date = DateTime.parse(item['date']);
      String monthYear = DateFormat('MMM yyyy').format(date);
      double amount = item['amount'];
      monthlySalesMap.update(monthYear, (value) => value + amount,
          ifAbsent: () => amount);
    }

    List<Map<String, dynamic>> monthlySalesData =
        monthlySalesMap.entries.map((entry) {
      return {
        'month': entry.key,
        'value': entry.value,
      };
    }).toList();

    return monthlySalesData;
  }

  @override
  Widget build(BuildContext context) {
    double aggregateSales = getAggregateSales();
    List<Map<String, dynamic>> monthlySalesData = getMonthlySalesData();

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
                () {
                  // TODO: Add your logic to render the chart for Today Sales
                  print('Today Sales chart clicked');
                },
              ),
              SizedBox(width: 16),
              _buildStatCard(
                'Total Sales',
                '₦${getTotalSales().toStringAsFixed(2)}',
                Icons.monetization_on,
                Colors.green,
                () {
                  // Toggle the visibility of the chart on click
                  setState(() {
                    showChart = !showChart;
                  });
                },
              ),
              SizedBox(width: 16),
              _buildStatCard(
                'Today Invoices',
                '',
                Icons.receipt,
                Colors.orange,
                () {
                  // TODO: Add your logic to render the chart for Today Invoices
                  print('Today Invoices chart clicked');
                },
              ),
              SizedBox(width: 16),
              _buildStatCard(
                'Products Sold Today',
                getProductsSoldToday(),
                Icons.shopping_cart,
                Colors.red,
                () {
                  // Toggle the visibility of the chart on click
                  setState(() {
                   showProductSoldChartWidget = !showProductSoldChartWidget;
                  });
                },
              ),
            ],
          ),

          SizedBox(height: 16),
          Divider(),

          // Display the ChartWidget with monthly sales data and aggregate sales
           if (showProductSoldChartWidget)
           ProductSoldChartWidget(
  futureProductSoldData: Future.value(staticProductSoldData),
  aggregateSales: 1000.0, // Replace this with the actual aggregate sales
),

          if (showChart) ChartWidget(
              monthlySalesData: monthlySalesData,
              aggregateSales: aggregateSales),

          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, dynamic value, IconData icon, Color color,
      VoidCallback onClick) {
    return Expanded(
      child: GestureDetector(
        onTap: onClick,
        child: MouseRegion(
          onEnter: (event) {
            // TODO: Add your hover effect here (e.g., change the color or add a shadow).
            print('Mouse entered $title');
          },
          onExit: (event) {
            // TODO: Add your hover effect here (e.g., revert the color or remove the shadow).
            print('Mouse exited $title');
          },
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
        ),
      ),
    );
  }
}

class ChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> monthlySalesData;
  final double aggregateSales;

  ChartWidget({required this.monthlySalesData, required this.aggregateSales});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: _buildBarChart(monthlySalesData),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement toggle feature to switch between monthly and aggregate sales
              // For simplicity, we can just print the aggregate sales for now.
              print('Aggregate Sales: ₦${aggregateSales.toStringAsFixed(2)}');
            },
            child: Text('Show Aggregate Sales'),
          ),
        ],
      ),
    );
  }
  // Inside _AnalysisDashboardState

  int selectedYear = DateTime.now().year;
  Widget _buildBarChart(List<Map<String, dynamic>> data) {
    List<charts.Series<Map<String, dynamic>, String>> seriesList = [
      charts.Series<Map<String, dynamic>, String>(
        id: 'Sales',
        domainFn: (Map<String, dynamic> sales, _) => sales['month'],
        measureFn: (Map<String, dynamic> sales, _) => sales['value'],
        data: data,
        // Add the label accessor function for displaying values on top of the bars
        labelAccessorFn: (Map<String, dynamic> sales, _) =>
            '\₦${sales['value'].toStringAsFixed(2)}',
      ),
    ];

    return charts.BarChart(
      seriesList,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 14,
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 14,
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
      // Add the BarLabelDecorator to display custom labels on top of the bars
      barRendererDecorator: charts.BarLabelDecorator<String>(),
    );
  }
}




class ProductSoldData {
  final String itemName;
  final int quantity;
  final DateTime salesTime;

  ProductSoldData({
    required this.itemName,
    required this.quantity,
    required this.salesTime,
  });
}

class ProductSoldChartWidget extends StatelessWidget {
  final Future<List<ProductSoldData>> futureProductSoldData;
  final double aggregateSales;

  ProductSoldChartWidget({
    required this.futureProductSoldData,
    required this.aggregateSales,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: FutureBuilder<List<ProductSoldData>>(
              future: futureProductSoldData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Return a progress indicator while waiting for the data
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Handle error cases
                  return Center(child: Text('Error loading data'));
                } else {
                  // Build the chart using the fetched data
                  return _buildBarChart(snapshot.data!);
                }
              },
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement toggle feature to switch between monthly and aggregate sales
              // For simplicity, we can just print the aggregate sales for now.
              print('Aggregate Sales: ₦${aggregateSales.toStringAsFixed(2)}');
            },
            child: Text('Show Aggregate Sales'),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(List<ProductSoldData> data) {
    List<charts.Series<ProductSoldData, String>> seriesList = [
      charts.Series<ProductSoldData, String>(
        id: 'Sales',
        domainFn: (ProductSoldData sales, _) => sales.itemName,
        measureFn: (ProductSoldData sales, _) => sales.salesTime.month,
        data: data,
        // Add the label accessor function for displaying values on top of the bars
        labelAccessorFn: (ProductSoldData sales, _) => '${sales.quantity}',
      ),
    ];

    return charts.BarChart(
      seriesList,
      animate: true,
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 14,
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 14,
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
      // Add the BarLabelDecorator to display custom labels on top of the bars
      barRendererDecorator: charts.BarLabelDecorator<String>(),
    );
  }
}





