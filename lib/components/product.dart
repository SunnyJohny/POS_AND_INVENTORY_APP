import 'package:flutter/material.dart';



class Product {
  String name;
  double price;
  Color color;
  int quantity;

  Product(this.name, this.price, this.color, {this.quantity = 1});

  void incrementQuantity() {
    quantity++;
  }

 void decrementQuantity(List<Product> cartItems) {
  if (quantity > 1) {
    quantity--;
  } else {
    // Remove the item from the cart
    quantity = 1;
    cartItems.remove(this);
  }
}


  double get totalPrice {
    return price * quantity;
  }
}
