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
  final List<double> operatingExpenses;
  final double profit;

  ProfitAndLossStatementModal({
    required this.revenue,
    required this.cogs,
    required this.operatingExpenses,
    required this.profit,
  });

  @override
  Widget build(BuildContext context) {
    final statementDate = DateTime.now();

    return Material(
      color: Colors.white,
      child: Container(
        width: 800,
        padding: EdgeInsets.all(16),
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
              'Statement Date: ${DateFormat('MM/dd/yyyy').format(statementDate)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Revenue:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Cost of Goods Sold (COGS):',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Operating Expenses:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\₦${revenue.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '\₦${cogs.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '\₦${operatingExpenses.reduce((a, b) => a + b).toStringAsFixed(2)}',
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
                Text(
                  'Profit:',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '\₦${profit.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16),
                ),
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
                    Fluttertoast.showToast(
                      msg: 'Printing and saving in progress...',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey[800],
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    await savePdf();
                    await printPdf();
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
                              '\₦${operatingExpenses.reduce((a, b) => a + b).toStringAsFixed(2)}',
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

