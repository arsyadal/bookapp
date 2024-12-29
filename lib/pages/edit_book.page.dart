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
    _publishedYearController = TextEditingController(text: widget.book.publishedYear.toString());
    _isbnController = TextEditingController(text: widget.book.isbn);
    _imageUrlController = TextEditingController(text: widget.book.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
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
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an author';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genreController,
                decoration: InputDecoration(labelText: 'Genre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a genre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _publishedYearController,
                decoration: InputDecoration(labelText: 'Published Year'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a published year';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _isbnController,
                decoration: InputDecoration(labelText: 'ISBN'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an ISBN';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Call API to update book
                    apiService.updateBook(Book(
                      id: widget.book.id,
                      title: _titleController.text,
                      author: _authorController.text,
                      genre: _genreController.text,
                      publishedYear: int.parse(_publishedYearController.text),
                      isbn: _isbnController.text,
                      imageUrl: _imageUrlController.text,
                    ));
                    Navigator.pop(context);
                  }
                },
                child: Text('Save Changes'),
                   style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Mengatur warna tombol menjadi biru
                  foregroundColor: Colors.white, // Mengatur warna teks menjadi putih
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}