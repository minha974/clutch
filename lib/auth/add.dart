// ignore_for_file: implementation_imports
import 'package:flutter/material.dart';
// ignore: unused_import
import "package:flutter/src/widgets/container.dart";
// ignore: unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/MainPage/FirstPage.dart';
import 'package:flutter_application_1/auth/auth_service.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await authService.signInWithEmailPassword(email, password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Firstpage()), // Replace with your actual first page widget
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "W e l c o m e",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true, // Center the title for better UI
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      label: Text("Create your account"),
                      hintText: ("Email")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    label: Text("Password"),
                  ),
                ),
              ), SizedBox(height: 20,),
        SizedBox(
          width: 370,
          height: 45,// Adjust the width here
          child: ElevatedButton(
            onPressed: login,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF86ab0c), // Background color of the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              padding: EdgeInsets.symmetric(vertical: 12.0), // Padding inside the button
            ),
            child: Text(
              "Sign in",
              style: TextStyle(
                color: Colors.black, // Text color
                fontWeight: FontWeight.bold, // Bold text
                fontSize: 17, // Font size
              ),
            ),
          ),),
              Text("Do not have an Account?"),
              GestureDetector(
                onTap: () {
                  // Navigate to the signup page
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  'Register Now',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ), // Empty body
    );
  }
}
