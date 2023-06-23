import 'package:flutter/material.dart';
import 'package:my_desktop_app/components/product.dart';
import 'package:my_desktop_app/components/receipt.dart';


import 'package:provider/provider.dart';
import 'package:my_desktop_app/components/providers/product_cart_provider.dart';


class CartPanel extends StatelessWidget {
  final List<Product> cartItems;
  final VoidCallback updateTotal;
  final VoidCallback clearCart;

  CartPanel({
    required this.cartItems,
    required this.updateTotal,
    required this.clearCart,
  });

  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }

   return Container(
  width: 300,
  color: Colors.grey[200],
  padding: EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              'Cart',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'Total',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Divider(),
      Expanded(
        child: ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            Product product = cartItems[index];
            double itemTotal = product.price * product.quantity; // Calculate total for each item

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(product.name),
                ),
                Row(
                  children: [
                  IconButton(
  icon: Icon(Icons.remove),
  onPressed: () {
    if (product.quantity > 1) {
       product.decrementQuantity(cartItems);
      updateTotal();
    } else {
      Provider.of<ProductCartProvider>(context, listen: false).removeItem(product);
    }
  },
),

                    Text(product.quantity.toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        ProductCartProvider productCartProvider = Provider.of<ProductCartProvider>(context, listen: false);
                        productCartProvider.incrementQuantity(product);
                        updateTotal();
                      },
                    ),
                  ],
                ),
                Text('\$${itemTotal.toStringAsFixed(2)}'), // Display item total
              ],
            );
          },
        ),
      ),
      SizedBox(height: 10),
      Text(
        'Total: \$${total.toStringAsFixed(2)}',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the ReceiptScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReceiptScreen(
                      cartItems: cartItems,
                      total: total,
                    ),
                  ),
                );
              },
              child: Text('Receipt'),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: clearCart,
              child: Text('Clear Cart'),
            ),
          ),
        ],
      ),
    ],
  ),
);
 return Container(
      width: 300,
      color: Colors.grey[200],
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Cart',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'Total',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                Product product = cartItems[index];
                double itemTotal = product.price * product.quantity; // Calculate total for each item

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(product.name),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (product.quantity > 1) {
                              product.decrementQuantity(cartItems);
                              updateTotal();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Removed ${product.name} from cart.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              // clearCart();
                            }
                          },
                        ),
                        Text(product.quantity.toString()),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            product.incrementQuantity();
                            updateTotal();
                          },
                        ),
                      ],
                    ),
                    Text('\$${itemTotal.toStringAsFixed(2)}'), // Display item total
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Total: \$${total.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the ReceiptScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReceiptScreen(
                          cartItems: cartItems,
                          total: total,
                        ),
                      ),
                    );
                  },
                  child: Text('Receipt'),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: clearCart,
                  child: Text('Clear Cart'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
