import 'dart:convert';

import 'package:flutter_web_api/cliente/model.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUri = "https://localhost:7267/api/Cliente";

  Future<List<Empleado>> getUserData() async {
    List<Empleado> data = [];

    final uri = Uri.parse(baseUri);
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        data = jsonData.map((json) => Empleado.fromJson(json)).toList();
      }
    } catch (e) {
      return data;
    }
    return data;
  }

  Future<http.Response> updateUser(
      {required int userId, required Empleado user}) async {
    final uri = Uri.parse("$baseUri/$userId");
    late http.Response response;

    try {
      response = await http.put(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode(user),
      );
    } catch (e) {
      return response;
    }

    return response;
  }

  Future<http.Response> addUser({required Empleado user}) async {
    final uri = Uri.parse(baseUri);
    late http.Response response;

    try {
      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode(user),
      );
    } catch (e) {
      return response;
    }

    return response;
  }

  Future<http.Response> deleteUser({required int userId}) async {
    final uri = Uri.parse("$baseUri/$userId");
    late http.Response response;

    try {
      response = await http.delete(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      return response;
    }
    return response;
  }

  Future<Empleado> getUserById({required int userId}) async {
    final uri = Uri.parse("$baseUri/$userId");
    Empleado? user;
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        user = Empleado.fromJson(jsonData);
      }
    } catch (e) {
      return user!;
    }
    return user!;
  }
}
