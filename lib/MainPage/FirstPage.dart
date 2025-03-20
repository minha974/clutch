import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainPage/toolls.dart';
import 'package:flutter_application_1/auth/add.dart';
import 'package:flutter_application_1/vehicle_recovery/location.dart';
import '../Service/Service.dart';
import '../auth/auth_service.dart';
import '../first_aid/aid.dart';
import '../main.dart';
import '../vids/fix.dart'; // Import your Service page

class Firstpage extends StatefulWidget {
  @override
  _FirstpageState createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  final authService = AuthService();
  void logout() async {
    await authService.signOut();  // Sign the user out
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AddUser()), // Navigate to LoginPage
    );
  }
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();
  List<String> _allItems = ["Nearby shops", "Buy parts", "First Aid"];
  List<String> _filteredItems = [];
  int _currentImageIndex = 0;
  late Timer _timer;

  final List<Map<String, String>> _data = [
    {'image': 'assets/issue.jpg', 'text': 'Facing an issue with your engine?'},
    {'image': 'assets/tire.jpg', 'text': 'Does your tire seem off?'},
  ];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;  // Initially show all items
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _changeContent();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Change the content (image and text)
  void _changeContent() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _data.length;
    });
  }

  // Filter the search results
  void _filterItems(String query) {
    setState(() {
      _filteredItems = _allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Handle bottom navigation item selection
  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ServicePage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FinalView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.car_repair, color: Color(0xFF86ab0c),),
        title: const Text("CLUTCH"),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: logout,  // Log out when the icon is pressed
            icon: const Icon(Icons.logout, color:  Color(0xFF86ab0c)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: _searchController,
                onChanged: _filterItems, // Call filter when text changes
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(child: Icon(Icons.search, color: Colors.white,), decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),  bottomLeft: Radius.circular(10),), color: Colors.grey[700],), height: 70,width: 70,),
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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey[500],),
                width: 400,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filteredItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_filteredItems[index],style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      onTap: () {
                        // Navigate to the corresponding page based on the search item
                        if (_filteredItems[index] == "Nearby shops") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FinalView()),
                          );
                        } else if (_filteredItems[index] == "Buy parts") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Toolls()),
                          );
                        } else if (_filteredItems[index] == "First Aid") {
                          // Handle navigation for First Aid (you can add a page for it)
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FirstAidPage()), // Replace with the actual page
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            // GestureDetector for the image content
            GestureDetector(
              onTap: () {
                if (_currentImageIndex == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FixPage()), // Navigate to FixPage when second image is clicked
                  );
                }
              },
              child: Container(
                margin: EdgeInsets.all(20),
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(_data[_currentImageIndex]['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        _data[_currentImageIndex]['text']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FinalView()),
                );
              },
              child: Container(
                width: 500,
                height: 100,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFEDEDED),
                ),
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.car_repair_outlined),
                    SizedBox(width: 7),
                    Text(
                      'Recovery vehicle',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),// Gesture Detectors for the parts and shops options
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Toolls()),
                );
              },
              child: Container(
                width: 500,
                height: 100,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFEDEDED),
                ),
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_outlined),
                    SizedBox(width: 7),
                    Text(
                      'Buy parts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FixPage()),
                );
              },
              child: Container(
                width: 500,
                height: 100,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFEDEDED),
                ),
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 7),
                    Text(
                      'Nearby showrooms',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstAidPage()),
                );
              },
              child: Container(
                width: 500,
                height: 100,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFEDEDED),
                ),
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_hospital_rounded),
                    SizedBox(width: 7),
                    Text(
                      'First Aid',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstAidPage()),
                );
              },
              child: Container(
                width: 500,
                height: 100,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFEDEDED),
                ),
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_gas_station),
                    SizedBox(width: 7),
                    Text(
                      'Fuel',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Additional containers (e.g., First Aid) can be added here
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
            icon: Icon(Icons.business, size: 30),
            label: 'Service',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
