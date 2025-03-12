import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../MainPage/FirstPage.dart';
import '../MainPage/cart.dart';
import '../MainPage/tool.dart';
import 'cartitem.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      // Navigate to the Service Page when the "Service" tab is clicked
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Firstpage()),
      );
    }
    if (index == 1) {
      // Navigate to the Service Page when the "Service" tab is clicked
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ServicePage()),
      );
      // Navigate to the Profile Page
      // Add your ProfilePage navigation logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, value, child) => Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            const Text(
              'My Cart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: value.getUserCart().length,
                itemBuilder: (context, index) {
                  // Get individual tool
                  Tool individualTool = value.getUserCart()[index];
                  // Return cart item
                  return CartItem(tool: individualTool);
                },
              ),
            ),
            // Button at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,  // Full width
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle "Order Now" button press here
                      // For example, navigate to an order confirmation screen
                      print('Order Now clicked');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF86ab0c),  // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),  // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'Order Now',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
