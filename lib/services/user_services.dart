// filepath: /Users/macintoshhd/Documents/PERPUS/bookapp/lib/services/user_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class UserService {
  final String baseUrl = 'http://localhost:3000/api/users';

  Future<User> registerUser(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<String> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['token'];
    } else {
      throw Exception('Failed to login');
    }
  }
}