import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'aid2.dart';
import 'aid3.dart';
import 'carta.dart';

class FirstAidPage extends StatefulWidget {
  @override
  State<FirstAidPage> createState() => _FirstAidPageState();
}

class _FirstAidPageState extends State<FirstAidPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> _allItems = ["Bandage", "Antiseptic", "Gauze", "band-aid"]; // Updated list
  List<String> _filteredItems = [];
  ScrollController _scrollController = ScrollController(); // Controller to scroll the list

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
      // Calculate the offset by using the index from the filtered list
      _scrollController.animateTo(
        (index) * 250.0, // Adjust this value based on your tile height
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirstAidCart>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('First Aid'),
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
                        'Shop for First Aids!',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  height: 500,
                  width: double.infinity,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: cart.getFirstAidList().length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      FirstAid firstAid = cart.getFirstAidList()[index];
                      return FirstAidTile(
                        firstAid: firstAid,
                        onTap: () => cart.addItemToCart(firstAid),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Color(0xFF86ab0c),
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
            onTap: (index) {
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              }
            },
          ),
        );
      },
    );
  }
}

class FirstAidTile extends StatelessWidget {
  final FirstAid firstAid;
  final Function()? onTap;

  FirstAidTile({required this.firstAid, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25),
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Image.asset(firstAid.imagePath, width: 200),
          Text(
            firstAid.description,
            style: TextStyle(color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      firstAid.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      '\$' + firstAid.price,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    child: Icon(
                      Icons.add,
                      color: Color(0xFF86ab0c),
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
