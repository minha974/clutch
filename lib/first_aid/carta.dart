import 'package:flutter/cupertino.dart';
import 'aid.dart';
import 'aid2.dart';
class Cartt extends ChangeNotifier{
  //list of tools
  List<Aid> aidShop=[
    Aid(name: 'Tire',
        price: '5000',
        imagePath: 'assets/tyre.jpg',
        description: 'tire vro'),
    Aid(name: 'Mirror',
        price: '3000',
        imagePath: 'assets/steering.jpg',
        description: 'description'),
    Aid(name: 'Jockey',
        price: '500',
        imagePath: 'assets/tyre.jpg',
        description: 'description'),
    Aid(name: 'Steering Wheel',
        price: '5000',
        imagePath: 'assets/tyre.jpg',
        description: 'description'),
  ];

  //list of tools in user cart
  List<Aid> userCart =[];
  //sale
  List<Aid> getAidList(){
    return aidShop;
  }
  //get cart
  List<Aid> getUserCart() {
    return userCart;
  }
  //add
  void addItemToCart(Aid aid){
    userCart.add(aid);
    notifyListeners();
  }
  //delete
  void removeItemFromCart(Aid aid){
    userCart.remove(aid);
    notifyListeners();
  }
}