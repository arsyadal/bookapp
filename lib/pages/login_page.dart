// filepath: /Users/macintoshhd/Documents/PERPUS/bookapp/lib/pages/login_page.dart
import 'package:flutter/material.dart';
import '../services/user_services.dart';
import 'book_list_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final UserService userService = UserService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final token = await userService.loginUser(
                        _emailController.text,
                        _passwordController.text,
                      );
                      // Store the token and navigate to the home page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => BookListPage()),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to login')),
                      );
                    }
                  }
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  foregroundColor: Colors.white, // Text color
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
