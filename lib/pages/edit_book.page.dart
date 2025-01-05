import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';

class EditBookPage extends StatefulWidget {
  final Book book;

  EditBookPage({required this.book});

  @override
  _EditBookPageState createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _genreController;
  late TextEditingController _publishedYearController;
  late TextEditingController _isbnController;
  late TextEditingController _imageUrlController;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.author);
    _genreController = TextEditingController(text: widget.book.genre);
    _publishedYearController = TextEditingController(text: widget.book.publishedYear?.toString());
    _isbnController = TextEditingController(text: widget.book.isbn);
    _imageUrlController = TextEditingController(text: widget.book.imageUrl);
  }

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

  Future<void> _updateBook() async {
    if (_formKey.currentState!.validate()) {
      final updatedBook = Book(
        id: widget.book.id,
        title: _titleController.text,
        author: _authorController.text,
        genre: _genreController.text,
        publishedYear: int.tryParse(_publishedYearController.text),
        isbn: _isbnController.text,
        imageUrl: _imageUrlController.text,
        isAvailable: widget.book.isAvailable, // Maintain the current availability status
        borrowedBy: widget.book.borrowedBy,
        borrowedAt: widget.book.borrowedAt,
        createdAt: widget.book.createdAt,
        updatedAt: DateTime.now(),
      );

      try {
        await apiService.updateBook(updatedBook);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Book updated successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update book')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
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
                onPressed: _updateBook,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  foregroundColor: Colors.white, // Text color
                ),
                child: Text('Update Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}