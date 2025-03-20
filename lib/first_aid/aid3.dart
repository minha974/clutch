import 'package:flutter/material.dart';
import 'aid2.dart';
 // Import FirstAid model

class FirstAidCart extends ChangeNotifier {
  // List of FirstAid items available for purchase
  List<FirstAid> firstAidShop = [
    FirstAid(
      name: 'Bandage',
      price: '10',
      imagePath: 'assets/bandage.jpg', // Replace with your image
      description: 'A medical bandage for injuries',
    ),
    FirstAid(
      name: 'Antiseptic',
      price: '15',
      imagePath: 'assets/antiseptic.jpg', // Replace with your image
      description: 'Antiseptic solution for cleaning wounds',
    ),
    FirstAid(
      name: 'Gauze',
      price: '5',
      imagePath: 'assets/gauze.jpg', // Replace with your image
      description: 'Sterile gauze pads',
    ),
    // Add more items as needed
  ];

  // List of items in the user's cart
  List<FirstAid> userCart = [];

  // Get the list of available first aid items
  List<FirstAid> getFirstAidList() {
    return firstAidShop;
  }

  // Get the user's cart
  List<FirstAid> getUserCart() {
    return userCart;
  }

  // Add item to the cart
  void addItemToCart(FirstAid firstAid) {
    userCart.add(firstAid);
    notifyListeners();
  }

  // Remove item from the cart
  void removeItemFromCart(FirstAid firstAid) {
    userCart.remove(firstAid);
    notifyListeners();
  }
}
