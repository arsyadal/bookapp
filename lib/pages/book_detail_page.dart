import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';

class BookDetailPage extends StatelessWidget {
  final int bookId;

  BookDetailPage({required this.bookId});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Detail'),
        backgroundColor: Colors.blue, // Mengatur warna navbar menjadi biru
        
      ),
      body: FutureBuilder<Book>(
        future: apiService.getBookById(bookId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load book details'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Book not found'));
          } else {
            Book book = snapshot.data!;
            return Center(
              child: Card(
                margin: EdgeInsets.all(16.0),
                elevation: 8.0, // Menambahkan bayangan pada Card
                color: Colors.white, // Mengatur background Card menjadi putih
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book.title, style: TextStyle(fontSize: 24)),
                      SizedBox(height: 8),
                      Text('Author: ${book.author}'),
                      SizedBox(height: 8),
                      Text('Genre: ${book.genre}'),
                      SizedBox(height: 8),
                      Text('Published Year: ${book.publishedYear}'),
                      SizedBox(height: 8),
                      Text('ISBN: ${book.isbn}'),
                      SizedBox(height: 8),
                      Image.network(
                        book.imageUrl,
                        width: 200, // Set the desired width
                        height: 300, // Set the desired height
                        fit: BoxFit.cover, // Ensure the image covers the box
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}