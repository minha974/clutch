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
      backgroundColor:  Color(0xFF86ab0c),
      body: Center(
        child: Column( mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text('CLUTCH' ,style: TextStyle(fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/auth'); // Navigate to AddUser page
        },
        backgroundColor: Color(0xFF86ab0c),
        child: const Icon(
          Icons.double_arrow_outlined,
          color: Colors.black,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
