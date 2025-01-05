import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';

class BookDetailPage extends StatefulWidget {
  final int bookId;

  BookDetailPage({required this.bookId});

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late ApiService apiService;
  late Future<Book> bookFuture;
  final int userId = 1; // Replace with the actual user ID

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    bookFuture = apiService.getBookById(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Detail'),
        backgroundColor: Colors.blue, // Mengatur warna navbar menjadi biru
      ),
      body: FutureBuilder<Book>(
        future: bookFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load book details'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Book not found'));
          } else {
            Book book = snapshot.data!;
            bool isAvailable = book.borrowedBy == null;
            return SingleChildScrollView(
              child: Center(
                child: Card(
                  margin: EdgeInsets.all(16.0),
                  elevation: 8.0, // Menambahkan bayangan pada Card
                  color: Colors.white, // Mengatur background Card menjadi putih
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(book.title, style: TextStyle(fontSize: 24)),
                        SizedBox(height: 8),
                        Text('Author: ${book.author}'),
                        SizedBox(height: 8),
                        Text('Genre: ${book.genre ?? "N/A"}'),
                        SizedBox(height: 8),
                        Text('Published Year: ${book.publishedYear ?? "N/A"}'),
                        SizedBox(height: 8),
                        Text('ISBN: ${book.isbn ?? "N/A"}'),
                        SizedBox(height: 8),
                        if (book.imageUrl != null)
                          Image.network(
                            book.imageUrl!,
                            width: 200, // Set the desired width
                            height: 300, // Set the desired height
                            fit: BoxFit.cover, // Ensure the image covers the box
                            errorBuilder: (context, error, stackTrace) {
                              return Text('Failed to load image');
                            },
                          )
                        else
                          Text('No image available'),
                        SizedBox(height: 8),
                        Text(
                          'Available: ${isAvailable ? "Yes" : "No"}',
                          style: TextStyle(
                            color: isAvailable ? Colors.green : Colors.red,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('Borrowed By: ${book.borrowedBy ?? "N/A"}'),
                        SizedBox(height: 8),
                        Text('Borrowed At: ${book.borrowedAt?.toString() ?? "N/A"}'),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: isAvailable
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          await apiService.borrowBook(widget.bookId, userId); // Use the actual user ID
                                          // Refresh the book details
                                          setState(() {
                                            bookFuture = apiService.getBookById(widget.bookId);
                                          });
                                        } catch (e) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Failed to borrow book')),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue, // Background color
                                        foregroundColor: Colors.white, // Text color
                                      ),
                                      child: Text('Borrow Book'),
                                    )
                                  : ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          await apiService.returnBook(widget.bookId);
                                          // Refresh the book details
                                          setState(() {
                                            bookFuture = apiService.getBookById(widget.bookId);
                                          });
                                        } catch (e) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Failed to return book')),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue, // Background color
                                        foregroundColor: Colors.white, // Text color
                                      ),
                                      child: Text('Return Book'),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
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