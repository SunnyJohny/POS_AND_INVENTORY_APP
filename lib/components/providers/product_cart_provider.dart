import 'package:flutter/material.dart';
import 'package:my_desktop_app/components/product.dart';

class ProductCartProvider extends ChangeNotifier {
  List<Product> products = [
    // Define your products
    Product('Product 1', 10.99, Colors.blue),
    Product('Product 2', 15.99, Colors.green),
    Product('Product 3', 8.99, Colors.grey),
    Product('Product 4', 10.99, Colors.blue),
    Product('Product 5', 15.99, Colors.green),
    Product('Product 6', 8.99, Colors.grey),
    Product('Product 7', 10.99, Colors.blue),
    Product('Product 8', 15.99, Colors.green),
    Product('Product 9', 8.99, Colors.grey),
    Product('Product 10', 10.99, Colors.blue),
    Product('Product 12', 15.99, Colors.green),
    Product('Product 13', 8.99, Colors.grey),
    Product('Product 14', 10.99, Colors.blue),
    Product('Product 15', 15.99, Colors.green),
    Product('Product 16', 8.99, Colors.grey),
    // Add more products here
  ];

  List<Product> filteredProducts = [];
  List<Product> cartItems = [];
  String searchText = '';

  void searchProduct(String query) {
    searchText = query;
    filteredProducts = products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

   void removeItem(Product product) {
    cartItems.remove(product);
    updateCartTotal();

    // Note: You will need to provide the context from the widget that uses this method
    // and uncomment the code below if you want to show a SnackBar.
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Removed ${product.name} from cart.'),
    //     duration: Duration(seconds: 2),
    //   ),
    // );
  }

  void updateCartTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    // Update the total amount
    notifyListeners();
  }

  void addToCart(Product product) {
  bool found = false;
  for (var item in cartItems) {
    if (item.name == product.name) {
      item.incrementQuantity();
      found = true;
      break;
    }
  }
  if (!found) {
    cartItems.add(product);
  }
  updateCartTotal();
}

  void clearCart() {
    cartItems.clear();
    updateCartTotal();

    // Note: You will need to provide the context from the widget that uses this method
    // and uncomment the code below if you want to show a SnackBar.
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Cart cleared.'),
    //     duration: Duration(seconds: 2),
    //   ),
    // );
  }
   void incrementQuantity(Product product) {
    bool found = false;
    for (var item in cartItems) {
      if (item.name == product.name) {
        item.quantity++;
        found = true;
        break;
      }
    }
    if (!found) {
      cartItems.add(product);
    }
    updateCartTotal();
  }

  void decrementQuantity(Product product) {
    bool found = false;
    for (var item in cartItems) {
      if (item.name == product.name) {
        if (item.quantity > 1) {
          item.quantity--;
        } else {
          cartItems.remove(item);
        }
        found = true;
        break;
      }
    }
    updateCartTotal();
  }


}

