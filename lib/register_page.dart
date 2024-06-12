import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _errorMessage = '';

  bool _isValidEmail(String email) {
    // Validación simple de formato de correo electrónico
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  Future<bool> _checkEmailExists(String email) async {
    try {
      final response = await http.get(
        Uri.parse('https://10.0.2.2:7267/api/Usuario/checkemail?email=$email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body['exists']; // Suponiendo que el servidor devuelve {"exists": true/false}
      } else {
        print('Failed to check email: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error checking email: $e');
      return false;
    }
  }

  Future<void> _register() async {
    setState(() {
      _errorMessage = '';
    });

    if (!_isValidEmail(_emailController.text)) {
      setState(() {
        _errorMessage = 'Please enter a valid email address.';
      });
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'Passwords do not match.';
      });
      return;
    }

    final emailExists = await _checkEmailExists(_emailController.text);
    if (emailExists) {
      setState(() {
        _errorMessage = 'Email already exists.';
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://10.0.2.2:7267/api/Usuario/register'),
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

      if (response.statusCode == 201) {
        // Registro exitoso
        Navigator.pop(context); // Vuelve a la página de login
      } else {
        print('Registration failed: ${response.statusCode} - ${response.body}');
        setState(() {
          _errorMessage = 'El correo ingresado ya esta registrado para otro usuario, ingresa otro.';
        });
      }
    } catch (e) {
      print('Error during registration: $e');
      setState(() {
        _errorMessage = 'An error occurred during registration.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Usuario'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirmar Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
