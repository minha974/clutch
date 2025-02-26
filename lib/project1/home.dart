// ignore: unused_import
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CLUTCH",
          style: TextStyle(
            color: Color.fromARGB(255, 207, 215, 236),
            fontSize: 30, // Larger font for heading
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0, // Adds spacing for style
          ),
        ),
        centerTitle: true, // Centers the text in the AppBar
        backgroundColor:
            const Color.fromARGB(255, 105, 117, 126), // Optional: Change color
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/auth'); // Navigate to AddUser page
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(
          Icons.arrow_right_sharp,
          color: Color.fromARGB(255, 207, 215, 236),
          size: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
