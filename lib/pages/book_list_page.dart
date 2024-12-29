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
  late Future<List<Book>> futureBooks;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureBooks = apiService.getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
        foregroundColor: Colors.white, // Mengatur warna teks menjadi putih

        actions: [
          IconButton(
            icon: Icon(Icons.add),
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
          ),
        ],
      ),
      backgroundColor:
          Colors.grey[200], // Mengatur background list buku menjadi abu-abu
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Book book = snapshot.data![index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditBookPage(book: book)),
                          ).then((value) {
                            setState(() {
                              futureBooks = apiService.getBooks();
                            });
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await apiService.deleteBook(book.id);
                          setState(() {
                            futureBooks = apiService.getBooks();
                          });
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BookDetailPage(bookId: book.id)),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
