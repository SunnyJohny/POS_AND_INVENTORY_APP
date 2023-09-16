List<Map<String, dynamic>> expenseData = [
  {
    'transactionId': 'TRX001',
    'date': '2023-07-15',
    'description': 'Expense 1',
    'exp': 'Office Rent', // Updated to Office Rent
    'category': 'Operating Expenses', // Added category field
    'amount': 500.0,
    'vendor': 'Vendor 1',
    'pMethod': 'Cash',
  },
  {
    'transactionId': 'TRX002',
    'date': '2023-07-15',
    'description': 'Expense 2',
    'exp': 'Workshops', // Updated to Workshops
    'category': 'Operating Expenses', // Added category field
    'amount': 250.0,
    'vendor': 'Vendor 2',
    'pMethod': 'Credit Card',
  },
  {
    'transactionId': 'TRX003',
    'date': '2023-07-15',
    'description': 'Expense 3',
    'exp': 'Workshops', // Updated to Workshops
    'category': 'Operating Expenses', // Added category field
    'amount': 450.0,
    'vendor': 'Vendor 2',
    'pMethod': 'Credit Card',
  },
  {
    'transactionId': 'TRX004',
    'date': '2023-07-15',
    'description': 'Expense 4',
    'exp': 'Equipment Repairs', // Updated to Equipment Repairs
    'category': 'Cost of Goods Sold', // Added category field
    'amount': 750.0,
    'vendor': 'Vendor 3', // Update vendor if needed
    'pMethod': 'Cash',
  },
  {
    'transactionId': 'TRX005',
    'date': '2023-07-16',
    'description': 'Expense 5',
    'exp': 'Advertising',
    'category': 'Operating Expenses',
    'amount': 300.0,
    'vendor': 'Vendor 4',
    'pMethod': 'Credit Card',
  },
  {
    'transactionId': 'TRX006',
    'date': '2023-07-16',
    'description': 'Expense 6',
    'exp': 'Office Supplies',
    'category': 'Operating Expenses',
    'amount': 150.0,
    'vendor': 'Vendor 5',
    'pMethod': 'Cash',
  },
  {
    'transactionId': 'TRX007',
    'date': '2023-07-17',
    'description': 'Expense 7',
    'exp': 'Rent/Lease',
    'category': 'Operating Expenses',
    'amount': 900.0,
    'vendor': 'Vendor 6',
    'pMethod': 'Credit Card',
  },
  {
    'transactionId': 'TRX0028',
    'date': '2023-07-17',
    'description': 'Expense 28',
    'exp': 'Rent/Lease',
    'category': 'Operating Expenses',
    'amount': 2.20,
    'vendor': 'Vendor 6',
    'pMethod': 'Credit Card',
  },
  {
    'transactionId': 'TRX0048',
    'date': '2023-07-17',
    'description': 'Expense 48',
    'exp': 'Rent/Lease',
    'category': 'Operating Expenses',
    'amount': 350.40,
    'vendor': 'Vendor 6',
    'pMethod': 'Credit Card',
  },
  {
    'transactionId': 'TRX078',
    'date': '2023-07-03',
    'description': 'Expense 8',
    'exp': 'equipment',
    'category': 'Operating Expenses',
    'amount': 260.50,
    'vendor': 'Vendor 6',
    'pMethod': 'Credit Card',
  },
  {
    'transactionId': 'TRX0068',
    'date': '2023-07-01',
    'description': 'Expense 568',
    'exp': 'Rent/Lease',
    'category': 'Operating Expenses',
    'amount': 260.50,
    'vendor': 'Vendor 6',
    'pMethod': 'Credit Card',
  },
  {
    'transactionId': '3',
    'date': '2023-07-10',
    'description': 'Expense 8',
    'exp': 'raw material',
    'category': 'cost of goods',
    'amount': 260.90,
    'vendor': 'Vendor 6',
    'pMethod': 'Credit Card',
  },
  {
    'transactionId': '4',
    'date': '2023-07-17',
    'description': 'Expense 78',
    'exp': 'tax payment',
    'category': 'tax',
    'amount': 960.90,
    'vendor': 'Vendor 6',
    'pMethod': 'Credit Card',
  },

  // Add more items here...
];

List<Map<String, dynamic>> profitAndLossData = [
  {
    'sn': '1',
    'id': '1', // Item ID or Number
    'transactionId': 'TRX001',
    'date': '2023-07-15',
    'itemname': 'Phone',
    'customer': 'John Doe',
    'quantity': 5,
    'cost': 50.5,

    'payment': 'Cash',
    'amount': 500.0,
    'attendant': 'Jane Smith',
    'status': 'Completed',
  },
  {
    'sn': '2',
    'id': '2', // Item ID or Number
    'transactionId': 'TRX002',
    'date': '${DateTime.now().toString().split(' ')[0]}',
    'itemname': 'Cream',
    'customer': 'Alice Johnson',
    'quantity': 6,
    'cost': 50,
    'amount': 250.0,
    'attendant': 'John Smith',
    'status': 'Completed',
  },
  {
    'sn': '3',
    'id': '3', // Item ID or Number
    'transactionId': 'TRX003',
    'date': '${DateTime.now().toString().split(' ')[0]}',
    'itemname': 'Paracetamol',
    'customer': 'Bob Williams',
    'quantity': 4,
    'cost': 100,

    // 'payment': 'Cash',
    'amount': 700.0,
    // 'attendant': 'Jane Doe',
    // 'status': 'Pending',
  },
  {
    'sn': '4',
    'id': '4', // Item ID or Number
    'transactionId': 'TRX003',
    'date': '${DateTime.now().toString().split(' ')[0]}',
    'itemname': 'Charger',
    'customer': 'Bob Williams',
    'quantity': 4,
    'cost': 100,

    'amount': 700.0,
    // 'attendant': 'Jane Doe',
    // 'status': 'Pending',
  },
  {
    'sn': '3',
    'id': '5', // Item ID or Number
    'transactionId': 'TRX003',
    'date': '${DateTime.now().toString().split(' ')[0]}',
    'itemname': 'Battery',
    'customer': 'Bob Williams',
    'quantity': 4,
    'cost': 80,

    'amount': 700.0,
    // 'attendant': 'Jane Doe',
    // 'status': 'Pending',
  },
  {
    'sn': '3',
    'id': '6', // Item ID or Number
    'transactionId': 'TRX003',
    'date': '2023-07-01',
    'itemname': 'Wears',
    'customer': 'Bob Williams',
    'quantity': 4,
    'cost': 20,

    'amount': 700.0,
    'attendant': 'Jane Doe',
    'status': 'Pending',
  },
  {
    'sn': '3',
    'id': '7', // Item ID or Number
    'transactionId': 'TRX003',
    'date': '2023-07-02',
    'itemname': 'Keys',
    'customer': 'Bob Williams',
    'quantity': 4,
    'cost': 90,

    'amount': 700.0,
    'attendant': 'Jane Doe',
    'status': 'Pending',
  },
  {
    'sn': '3',
    'id': '8', // Item ID or Number
    'transactionId': 'TRX003',
    'date': '2023-07-03',
    'itemname': 'Laptop',
    'customer': 'Bob Williams',
    'quantity': 4,
    'cost': 60,

    'amount': 700.0,
    'attendant': 'Jane Doe',
    'status': 'Pending',
  },

  // Add more items here...
];
