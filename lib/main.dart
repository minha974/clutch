import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_gate.dart';
import 'project1/home.dart';
import 'project1/add.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRybmJteWRmbmd2ZGJmcG16aXZ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA1NjQ1MDYsImV4cCI6MjA1NjE0MDUwNn0.aY7W4jvEGC7sfiQLLZ9HYRsa5X14TgXXq572EwwJNnM",
    url: "https://trnbmydfngvdbfpmzivu.supabase.co",
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App",
      debugShowCheckedModeBanner: false, // Remove debug banner
      initialRoute: '/', // Ensure the app starts on HomePage
      routes: {
        '/': (context) => const HomePage(),
        '/add': (context) => const AddUser(),
        '/auth': (context) => const AuthGate(),
      },
    );
  }
}
