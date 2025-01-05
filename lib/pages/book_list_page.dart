import 'package:book_app/pages/edit_book.page.dart';
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';
import 'book_detail_page.dart';
import 'add_book_page.dart';
import '../pages/edit_book.page.dart';
class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  late ApiService apiService;
  late Future<List<Book>> futureBooks;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    futureBooks = apiService.getBooks();
  }

  Future<void> _deleteBook(int id) async {
    try {
      await apiService.deleteBook(id);
      setState(() {
        futureBooks = apiService.getBooks();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete book')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
        backgroundColor: Colors.blue, // Mengatur warna navbar menjadi biru
      ),
      body: FutureBuilder<List<Book>>(
        future: futureBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load books'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No books available'));
          } else {
            List<Book> books = snapshot.data!;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                Book book = books[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailPage(bookId: book.id),
                      ),
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditBookPage(book: book),
                            ),
                          ).then((value) {
                            setState(() {
                              futureBooks = apiService.getBooks();
                            });
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          _deleteBook(book.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBookPage()),
          ).then((value) {
            setState(() {
              futureBooks = apiService.getBooks();
            });
          });
        },
        backgroundColor: Colors.blue, // Background color
        child: Icon(Icons.add, color: Colors.white), // Plus icon with white color
      ),
    );
  }
}