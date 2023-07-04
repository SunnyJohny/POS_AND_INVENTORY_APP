import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedOperation = 'Add New Product';
  List<String> _operations = ['Add New Product', 'Increment Quantity'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: _selectedOperation,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOperation = newValue!;
                });
              },
              items: _operations.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('$_selectedOperation'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              controller: _nameController,
                              decoration: InputDecoration(labelText: 'Product Name'),
                            ),
                            TextField(
                              controller: _categoryController,
                              decoration: InputDecoration(labelText: 'Category'),
                            ),
                            TextField(
                              controller: _priceController,
                              decoration: InputDecoration(labelText: 'Price'),
                              keyboardType: TextInputType.number,
                            ),
                            TextField(
                              controller: _quantityController,
                              decoration: InputDecoration(labelText: 'Quantity'),
                              keyboardType: TextInputType.number,
                            ),
                            InputDatePickerFormField(
                              fieldLabelText: 'Select Date',
                              fieldHintText: 'MM/DD/YYYY',
                              lastDate: DateTime(2100),
                              firstDate: DateTime(2000),
                              initialDate: DateTime.now(),
                              onDateSubmitted: (selectedDate) {
                                setState(() {
                                  _selectedDate = selectedDate;
                                });
                              },
                            ),
                            if (_selectedDate != null)
                              Text(
                                'Selected Date: ${_selectedDate.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            if (_selectedOperation == 'Add New Product') {
                              // Add new product logic
                            } else if (_selectedOperation == 'Increment Quantity') {
                              setState(() {
                                _nameController.text = 'John';
                              });
                            }
                            
                            // Reset the text fields
                            _nameController.clear();
                            _categoryController.clear();
                            _priceController.clear();
                            _quantityController.clear();
                            _selectedDate = null;
                            
                            // Close the dialog
                            Navigator.of(context).pop();
                          },
                          child: Text('$_selectedOperation'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Open Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
