import 'package:flutter/material.dart';
import 'package:my_desktop_app/components/product.dart';
import 'package:my_desktop_app/components/cart_panel.dart';
import 'package:my_desktop_app/components/side_panel.dart';


import 'package:provider/provider.dart';
import 'package:my_desktop_app/components/providers/product_cart_provider.dart';

class ProductTile extends StatefulWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductTile({
    required this.product,
    required this.onTap,
  });

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    ProductCartProvider productCartProvider =
        Provider.of<ProductCartProvider>(context, listen: false);

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          
          productCartProvider.addToCart(widget.product);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
            color: widget.product.color, // Set the background color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.product.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('\$${widget.product.price.toStringAsFixed(2)}'),
              if (isHovered)
                Tooltip(
                  message: 'Add to Cart',
                  child: Icon(Icons.add_shopping_cart),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POS Screen'),
      ),
      body: Row(
        children: [
          SidePanel(), 
          Expanded(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Product List',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      onChanged: (value) {
                        Provider.of<ProductCartProvider>(context, listen: false)
                            .searchProduct(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Product',
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Consumer<ProductCartProvider>(
                      builder: (context, provider, _) {
                        return GridView.count(
                          crossAxisCount: 8,
                          children: provider.products.map((product) {
                            return ProductTile(
                              product: product,
                              onTap: () {
                                provider.addToCart(product);
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
    CartPanel(
  cartItems: Provider.of<ProductCartProvider>(context).cartItems,
  updateTotal: Provider.of<ProductCartProvider>(context).updateCartTotal,
  clearCart: () {
    // Implement the logic to clear the cart
    Provider.of<ProductCartProvider>(context, listen: false).clearCart();
  },
)


        ],
      ),
    );
  }
}
