import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/MainPage/tool.dart';

class Cart extends ChangeNotifier{
  //list of tools
  List<Tool> toolShop=[
    Tool(name: 'Tire',
        price: '5000',
        imagePath: 'assets/tyre.jpg',
        description: 'tire vro'),
    Tool(name: 'Mirror',
        price: '3000',
        imagePath: 'assets/steering.jpg',
        description: 'description'),
    Tool(name: 'Jockey',
        price: '500',
        imagePath: 'assets/tyre.jpg',
        description: 'description'),
    Tool(name: 'Steering Wheel',
        price: '5000',
        imagePath: 'assets/tyre.jpg',
        description: 'description'),
  ];

  //list of tools in user cart
List<Tool> userCart =[];
  //sale
List<Tool> getToolList(){
  return toolShop;
}
  //get cart
List<Tool> getUserCart() {
  return userCart;
}
  //add
void addItemToCart(Tool tool){
  userCart.add(tool);
  notifyListeners();
}
  //delete
  void removeItemFromCart(Tool tool){
    userCart.remove(tool);
    notifyListeners();
  }
}