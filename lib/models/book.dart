class Book {
  final int id;
  final String title;
  final String author;
  final String? genre;
  final int? publishedYear;
  final String? isbn;
  final String? imageUrl;
  final bool isAvailable;
  final int? borrowedBy;
  final DateTime? borrowedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.genre,
    this.publishedYear,
    this.isbn,
    this.imageUrl,
    required this.isAvailable,
    this.borrowedBy,
    this.borrowedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Named constructor for creating a new book
  Book.create({
    required this.title,
    required this.author,
    this.genre,
    this.publishedYear,
    this.isbn,
    this.imageUrl,
  })  : id = 0, // Placeholder value
        isAvailable = true,
        borrowedBy = null,
        borrowedAt = null,
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      genre: json['genre'],
      publishedYear: json['publishedYear'],
      isbn: json['isbn'],
      imageUrl: json['imageUrl'],
      isAvailable: json['isAvailable'],
      borrowedBy: json['borrowedBy'],
      borrowedAt: json['borrowedAt'] != null ? DateTime.parse(json['borrowedAt']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
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
      'isAvailable': isAvailable,
      'borrowedBy': borrowedBy,
      'borrowedAt': borrowedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}