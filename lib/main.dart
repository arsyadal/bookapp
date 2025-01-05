import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book App',
      debugShowCheckedModeBanner: false, // Remove the debug banner

      theme: ThemeData(
        primarySwatch: Colors.blue, // Mengatur warna utama menjadi biru
        scaffoldBackgroundColor: const Color.fromARGB(
            255, 228, 228, 228), // Mengatur background aplikasi menjadi putih
        appBarTheme: AppBarTheme(
          color: Colors.blue, // Mengatur warna navbar menjadi biru
        ),
      ),
      home: LoginPage(), // Set the login page as the home page
    );
  }
}
