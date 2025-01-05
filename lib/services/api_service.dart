import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/book.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000/api/books';

  Future<List<Book>> getBooks() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<Book> getBookById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Book.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load book');
    }
  }

   Future<void> addBook(Book book) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(book.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add book');
    }
  }

  Future<void> updateBook(Book book) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${book.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(book.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update book');
    }
  }

  Future<void> deleteBook(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete book');
    }
  }

  Future<void> borrowBook(int id, int userId) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id/borrow'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId': userId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to borrow book');
    }
  }

  Future<void> returnBook(int id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id/return'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to return book');
    }
  }
}