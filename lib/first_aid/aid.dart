import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainPage/FirstPage.dart';
import 'package:flutter_application_1/MainPage/Tooltile.dart';
import 'package:flutter_application_1/MainPage/tool.dart';
import 'package:provider/provider.dart';
import 'carta.dart';
import '../MainPage/cart.dart';
import '../Service/Service.dart';
import 'aid3.dart';
class Aid extends StatefulWidget {
  const Aid({super.key});

  @override
  State<Aid> createState() => _AidState();
}

class _AidState extends State<Aid> {
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
  void addAidToCart(Aid aid){
    Provider.of<Cart>(context, listen: false).addItemToCart(aid);
    //alert user
    showDialog(context: context, builder: (context)=>AlertDialog(title: Text('Succesfully added to cart!'),content: Text('check yout cart'),),);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, value, child)=>Scaffold(
      appBar: AppBar( backgroundColor: Colors.transparent,),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color:Colors.grey[400],borderRadius: BorderRadius.circular(8)),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Search',),
                  Icon(Icons.search,
                    color: Colors.grey,),
                ],
              ),
            ),),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Bag your Aids! ',style: TextStyle(fontWeight: FontWeight.bold, fontSize:21,),),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            height: 550,
            width: double.infinity,
            child: ListView.builder( itemCount:4, scrollDirection: Axis.horizontal, itemBuilder: (context,index){
              Aid aid= value.getAidList()[index];
              return AidTile(aid: aid, onTap: () => addAidToCart(aid),);
            },),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor:  Color(0xFF86ab0c),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size:30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size:30),
            label: 'Cart',
          ),
        ],
      ),
    ));
  }
}
