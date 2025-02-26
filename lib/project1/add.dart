// ignore_for_file: implementation_imports
import 'package:flutter/material.dart';
// ignore: unused_import
import "package:flutter/src/widgets/container.dart";
// ignore: unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
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
          "ADD USER",
          style: TextStyle(
            color: Color.fromARGB(255, 207, 215, 236),
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true, // Center the title for better UI
        backgroundColor: Color.fromARGB(255, 105, 117, 126),
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
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    label: Text("Password"),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: login,
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ), // Empty body
    );
  }
}
