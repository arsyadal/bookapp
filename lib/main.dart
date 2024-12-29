import 'package:flutter/material.dart';
import 'pages/book_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Mengatur warna utama menjadi biru
        scaffoldBackgroundColor: const Color.fromARGB(255, 228, 228, 228), // Mengatur background aplikasi menjadi putih
        appBarTheme: AppBarTheme(
          color: Colors.blue, // Mengatur warna navbar menjadi biru
        ),
      ),
      home: BookListPage(),
      debugShowCheckedModeBanner: false, // Menyembunyikan tampilan debug
    );
  }
}