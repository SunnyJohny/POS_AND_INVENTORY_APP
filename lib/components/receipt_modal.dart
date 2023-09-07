import 'package:flutter/material.dart';
import 'package:my_desktop_app/components/product.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';

class ReceiptModal extends StatelessWidget {
  final String attendantName; // Attendant's name
  final List<Product> cartItems;
  final double total;

  ReceiptModal({required this.attendantName, required this.cartItems, required this.total});

  @override
  Widget build(BuildContext context) {
    // Generate a random receipt number
    final receiptNumber = generateReceiptNumber();

    // Get the current date and time
    final now = DateTime.now();

    return Center(
      child: Container(
        width: 400,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Attendant: $attendantName',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Receipt Number: $receiptNumber',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Date: ${DateFormat('MM/dd/yyyy').format(now)}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Time: ${DateFormat('HH:mm').format(now)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),
            Text(
              'Receipt',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Item',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Qty',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Unit Price',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Amount',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Expanded( // Wrap the ListView.builder with Expanded
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  Product product = cartItems[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            product.name,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            product.quantity.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '\₦${product.price.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '\₦${product.totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),
            Text(
              'Sub-Total: \₦${total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Tax: \₦${(total * 0.15).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Total: \₦${(total + (total * 0.15)).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Thank you for your purchase!',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
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

  String generateReceiptNumber() {
    final random = Random();
    final letter1 = String.fromCharCode(random.nextInt(26) + 65);
    final letter2 = String.fromCharCode(random.nextInt(26) + 65);
    final number = random.nextInt(900000) + 100000;
    return '$letter1$letter2-$number';
  }

  Future<void> savePdf() async {
    final pdf = pw.Document();

    final now = DateTime.now();
    final receiptNumber = generateReceiptNumber();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: pw.EdgeInsets.all(16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Your Company Name',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text('123 Main Street, City',
                    style: pw.TextStyle(fontSize: 16)),
                pw.Text('Phone: (123) 456-7890 ext. $receiptNumber',
                    style: pw.TextStyle(fontSize: 16)),
                pw.Text('Email: company@example.com',
                    style: pw.TextStyle(fontSize: 16)),
                pw.SizedBox(height: 20),
                pw.Divider(),
                pw.SizedBox(height: 20),
                pw.Text('Attendant: $attendantName',
                    style: pw.TextStyle(fontSize: 16)),
                pw.Text('Receipt Number: $receiptNumber',
                    style: pw.TextStyle(fontSize: 16)),
                pw.Text('Date: ${DateFormat('MM/dd/yyyy').format(now)}',
                    style: pw.TextStyle(fontSize: 16)),
                pw.Text('Time: ${DateFormat('HH:mm').format(now)}',
                    style: pw.TextStyle(fontSize: 16)),
                pw.SizedBox(height: 20),
                pw.Divider(),
                pw.SizedBox(height: 10),
                pw.Text('Receipt',
                    style: pw.TextStyle(
                        fontSize: 20, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Item',
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    pw.Text('Qty',
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    pw.Text('Unit Price',
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    pw.Text('Amount',
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.SizedBox(height: 10),
                pw.ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (pw.Context context, int index) {
                    Product product = cartItems[index];
                    return pw.Padding(
                      padding: pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(
                            flex: 3,
                            child: pw.Text(product.name,
                                style: pw.TextStyle(fontSize: 16)),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Text(product.quantity.toString(),
                                style: pw.TextStyle(fontSize: 16)),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Text(
                                '\₦${product.price.toStringAsFixed(2)}',
                                style: pw.TextStyle(fontSize: 16)),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Text(
                                '\₦${product.totalPrice.toStringAsFixed(2)}',
                                style: pw.TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                pw.SizedBox(height: 20),
                pw.Divider(),
                pw.SizedBox(height: 10),
                pw.Text('Sub-Total: \₦${total.toStringAsFixed(2)}',
                    style: pw.TextStyle(fontSize: 16)),
                pw.Text('Tax: \₦${(total * 0.15).toStringAsFixed(2)}',
                    style: pw.TextStyle(fontSize: 16)),
                pw.Text(
                    'Total: \₦${(total + (total * 0.15)).toStringAsFixed(2)}',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text('Thank you for your purchase!',
                    style: pw.TextStyle(
                        fontSize: 16, fontStyle: pw.FontStyle.italic)),
              ],
            ),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/receipt.pdf');
    await file.writeAsBytes(await pdf.save());

    Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  Future<void> printPdf() async {
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/receipt.pdf');
    final bytes = await file.readAsBytes();

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => bytes,
    );
  }
}
