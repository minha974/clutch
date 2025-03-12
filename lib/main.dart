import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_gate.dart';
import 'package:flutter_application_1/auth/signup.dart';
import 'package:provider/provider.dart';
import 'MainPage/FirstPage.dart';
import 'MainPage/cart.dart';
import 'project1/home.dart';
import 'auth/add.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'vehicle_recovery/location.dart';
// Import your location helper file

void main() async {
  await Supabase.initialize(
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRybmJteWRmbmd2ZGJmcG16aXZ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA1NjQ1MDYsImV4cCI6MjA1NjE0MDUwNn0.aY7W4jvEGC7sfiQLLZ9HYRsa5X14TgXXq572EwwJNnM',
    url: 'https://trnbmydfngvdbfpmzivu.supabase.co',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        title: "App",
        debugShowCheckedModeBanner: false,
        initialRoute: '/', // Ensure the app starts on HomePage
        routes: {
          '/': (context) => const HomePage(),
          '/add': (context) => const AddUser(),
          '/auth': (context) => const AuthGate(),
          '/signup': (context) => const Signup(),
          '/fst': (context) =>  Firstpage(),
        },
      ),
    );
  }
}
class Restaurant {
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  double distance = 0.0;  // Add this property to store the distance from the user

  Restaurant({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}
// Predefined list of restaurants with coordinates
List<Restaurant> allRestaurants = [
  Restaurant(
    name: 'Pizza Place',
    address: '123 Pizza St, Cityville',
    latitude: 40.7128,
    longitude: -74.0060,
  ),
  Restaurant(
    name: 'Burger Town',
    address: '456 Burger Ave, Cityville',
    latitude: 40.7138,
    longitude: -74.0050,
  ),
  Restaurant(
    name: 'Sushi Spot',
    address: '789 Sushi Rd, Cityville',
    latitude: 40.7148,
    longitude: -74.0040,
  ),
];
/// The main screen of the app (StatefulWidget to handle state changes)
class FinalView extends StatefulWidget {
  const FinalView({super.key});

  @override
  State<FinalView> createState() => _FinalViewState();
}

/// State class for `FinalView`
class _FinalViewState extends State<FinalView> {
  final LocationHelper locationHelper = LocationHelper();
  String userLocation = 'No data'; // Stores the location data
  bool _isLoading = true; // Tracks whether location is being fetched
  bool _isLoadingRestaurants = false;
  List<Restaurant> nearbyRestaurants = [];

  @override
  void initState() {
    super.initState();
    getLocation(); // Fetch the location when the screen loads
  }

  /// Fetches the user's location and updates the UI
  Future<void> getLocation() async {
    setState(() {
      _isLoading = true;
      _isLoadingRestaurants = false;
    });

    final locationData = await locationHelper.getUserLocation(); // Fetch location

    if (locationData != null) {
      setState(() {
        userLocation =
        'Latitude: ${locationData['latitude']}, Longitude: ${locationData['longitude']}\n'
            'City: ${locationData['city']}, Country: ${locationData['country']}\n'
            'Address: ${locationData['address']}';

        _isLoading = false; // Hide loading indicator
      });

      // Fetch nearby restaurants after location is retrieved
      await getNearbyRestaurants(locationData['latitude'], locationData['longitude']);
    } else {
      setState(() {
        userLocation = 'Location not found'; // Display error message
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  /// Function to filter restaurants based on proximity to the user's location
  Future<void> getNearbyRestaurants(double userLat, double userLon) async {
    setState(() {
      _isLoadingRestaurants = true;
    });

    double maxDistance = 5.0; // Maximum distance in kilometers

    List<Restaurant> nearby = [];
    for (var restaurant in allRestaurants) {
      double distance = calculateDistance(userLat, userLon, restaurant.latitude, restaurant.longitude);

      // Debug: Print each restaurant's distance from the user
      print('Restaurant: ${restaurant.name}, Distance: $distance km');

      if (distance <= maxDistance) {
        restaurant.distance = distance; // Set the calculated distance
        nearby.add(restaurant);
      }
    }

    setState(() {
      nearbyRestaurants = nearby;
      _isLoadingRestaurants = false;
    });

    // Debug: Print the number of nearby restaurants found
    print('Nearby restaurants: ${nearby.length}');
  }

  /// Haversine formula to calculate the distance between two points on the earth's surface
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double radius = 6371; // Radius of Earth in kilometers

    double dLat = _degToRad(lat2 - lat1);
    double dLon = _degToRad(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) * cos(_degToRad(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return radius * c; // Returns the distance in kilometers
  }

  double _degToRad(double deg) {
    return deg * (3.141592653589793 / 180); // Convert degrees to radians
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Showrooms'),
      ),
      body: Center(
        child: _isLoading
            ? const CupertinoActivityIndicator() // Show a loading indicator while fetching location
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userLocation,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => getNearbyRestaurants(40.7128, -74.0060), // New York location
              child: const Text('Refresh Location'),
            ),
            const SizedBox(height: 20),
            if (_isLoadingRestaurants)
              const CircularProgressIndicator()
            else if (nearbyRestaurants.isEmpty)
              const Text('No nearby restaurants found')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: nearbyRestaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = nearbyRestaurants[index];
                    return ListTile(
                      title: Text(restaurant.name),
                      subtitle: Text('${restaurant.address} - ${restaurant.distance.toStringAsFixed(2)} km'),
                      leading: const Icon(Icons.restaurant),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
