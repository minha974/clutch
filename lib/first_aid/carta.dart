import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'aid2.dart';
import 'aid3.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirstAidCart>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Your Cart'),
          ),
          body: cart.getUserCart().isEmpty
              ? Center(child: Text('Your cart is empty'))
              : ListView.builder(
            itemCount: cart.getUserCart().length,
            itemBuilder: (context, index) {
              FirstAid firstAid = cart.getUserCart()[index];
              return ListTile(
                leading: Image.asset(firstAid.imagePath),
                title: Text(firstAid.name),
                subtitle: Text('\$' + firstAid.price),
                trailing: IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    cart.removeItemFromCart(firstAid);
                  },
                ),
              );
            },
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Add your checkout logic here
                print('Proceeding to checkout');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF86ab0c),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'Book now',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
