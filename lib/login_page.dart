import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'indice.dart';
import 'register_page.dart';

class MainPageLogin extends StatefulWidget {
  @override
  _MainPageLoginState createState() => _MainPageLoginState();
}

class _MainPageLoginState extends State<MainPageLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  String _connectionMessage = '';
  String _userData = '';



  Future<void> _login() async {
    try {
      final response = await http.post(
        Uri.parse('https://10.0.2.2:7267/api/Usuario/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'usuario': _emailController.text,
          'contraseña': _passwordController.text,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Login successful: $data');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainMenu()),
        );
      } else {
        print('Login failed: ${response.statusCode} - ${response.body}');
        setState(() {
          _errorMessage = 'Login failed. Please check your credentials.';
        });
      }
    } catch (e) {
      print('Error during login: $e');
      setState(() {
        _errorMessage = 'An error occurred during login.';
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              _connectionMessage,
              style: TextStyle(color: _connectionMessage.contains('exitosa') ? Colors.green : Colors.red),
            ),
            if (_userData.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _userData,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Registrarte'),
            ),
          ],
        ),
      ),
    );
  }
}