import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainPage/FirstPage.dart';
import 'package:flutter_application_1/MainPage/Tooltile.dart';
import 'package:flutter_application_1/MainPage/tool.dart';
import 'package:provider/provider.dart';
import '../Service/Service.dart';
import 'cart.dart';

class Toolls extends StatefulWidget {
  const Toolls({super.key});

  @override
  State<Toolls> createState() => _ToollsState();
}

class _ToollsState extends State<Toolls> {
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();
  List<String> _allItems = ["Tire", "Mirror", "Jack", "Steering wheel"]; // Updated list
  List<String> _filteredItems = [];
  ScrollController _scrollController = ScrollController(); // Controller to scroll the list

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
    }
  }

  void addToolToCart(Tool tool) {
    Provider.of<Cart>(context, listen: false).addItemToCart(tool);
    //alert user
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Successfully added to cart!'),
        content: Text('Check your cart'),
      ),
    );
  }

  // Filter the search results
  void _filterItems(String query) {
    setState(() {
      _filteredItems = _allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Scroll to the specific item based on the search result
  void _scrollToItem(String item) {
    int index = _allItems.indexOf(item);
    if (index != -1) {
      _scrollController.animateTo(
        index * 200.0, // Adjust this value based on your tile height
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterItems, // Call filter when text changes
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: Colors.grey[700],
                        ),
                        height: 70,
                        width: 70,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              // Display filtered search results ONLY when there's text entered
              if (_searchController.text.isNotEmpty && _filteredItems.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[500],
                  ),
                  width: 400,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          _filteredItems[index],
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          // Scroll to the corresponding tile when an item is tapped
                          _scrollToItem(_filteredItems[index]);
                        },
                      );
                    },
                  ),
                ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Bag your tools! ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                height: 550,
                width: double.infinity,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Tool tool = value.getToolList()[index];
                    return ToolTile(
                      tool: tool,
                      onTap: () => addToolToCart(tool),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: Color(0xFF86ab0c),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, size: 30),
              label: 'Cart',
            ),
          ],
        ),
      ),
    );
  }
}
