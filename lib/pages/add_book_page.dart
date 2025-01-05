import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';

class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _genreController = TextEditingController();
  final _publishedYearController = TextEditingController();
  final _isbnController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _genreController.dispose();
    _publishedYearController.dispose();
    _isbnController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _addBook() async {
    if (_formKey.currentState!.validate()) {
      final newBook = Book.create(
        title: _titleController.text,
        author: _authorController.text,
        genre: _genreController.text,
        publishedYear: int.tryParse(_publishedYearController.text),
        isbn: _isbnController.text,
        imageUrl: _imageUrlController.text,
      );

      try {
        await apiService.addBook(newBook);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Book added successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add book')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
        backgroundColor: Colors.blue, // Mengatur warna navbar menjadi biru
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the author';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genreController,
                decoration: InputDecoration(labelText: 'Genre'),
              ),
              TextFormField(
                controller: _publishedYearController,
                decoration: InputDecoration(labelText: 'Published Year'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isNotEmpty && int.tryParse(value) == null) {
                    return 'Please enter a valid year';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _isbnController,
                decoration: InputDecoration(labelText: 'ISBN'),
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addBook,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  foregroundColor: Colors.white, // Text color
                ),
                child: Text('Add Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}