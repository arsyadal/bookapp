class Book {
  final int id;
  final String title;
  final String author;
  final String genre;
  final int publishedYear;
  final String isbn;
  final String imageUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.publishedYear,
    required this.isbn,
    required this.imageUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      genre: json['genre'],
      publishedYear: json['publishedYear'],
      isbn: json['isbn'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'genre': genre,
      'publishedYear': publishedYear,
      'isbn': isbn,
      'imageUrl': imageUrl,
    };
  }
}