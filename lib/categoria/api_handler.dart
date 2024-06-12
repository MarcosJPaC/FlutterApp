import 'dart:convert';

import 'package:flutter_web_api/categoria/model.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUri = "https://10.0.2.2:7267/api/Categoria/GetTodosLasCategorias";

  Future<List<Categoria>> getUserData() async {
    List<Categoria> data = [];

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

        // Filtrar los registros con status igual a 0
        data = jsonData
            .map((json) => Categoria.fromJson(json))
            .where((categoria) => categoria.status == 1)
            .toList();
      }
    } catch (e) {
      // Manejar cualquier error y devolver una lista vacía en caso de error
      return data;
    }

    return data;
  }

  Future<http.Response> updateUser({required int userId, required Categoria user}) async {
    final uri = Uri.parse(
        "https://10.0.2.2:7267/api/Categoria/ActualizarCategoria/UpdateCategoria/$userId?nombre=${Uri.encodeComponent(user.nombre)}&descripcion=${Uri.encodeComponent(user.descripcion)}&estado=${Uri.encodeComponent(user.estado)}");

    late http.Response response;

    try {
      response = await http.put(
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



  Future<http.Response> addUser({required Categoria user}) async {
    final uri = Uri.parse(
        "https://10.0.2.2:7267/api/Categoria/CrearCategoria/CreateCategoria?nombre=${Uri
            .encodeComponent(user.nombre)}&descripcion=${Uri.encodeComponent(
            user.descripcion)}&estado=${Uri.encodeComponent(
            user.estado)}&status=${user.status == 1
            ? 'true'
            : 'false'}"); // Convertir a 'true' o 'false'

    late http.Response response;

    try {
      response = await http.post(
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


  Future<http.Response> deleteUser({required int userId}) async {
    final uri = Uri.parse(
        "https://10.0.2.2:7267/api/Categoria/EliminarCategoria/DeleteCategoria/$userId");
    late http.Response response;

    try {
      response = await http.delete(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      // En caso de error, devuelve una respuesta vacía
      return response;
    }

    return response;
  }


  Future<Categoria?> getUserById({required int userId}) async {
    final baseUri = "https://localhost:7267/api/Categoria/GetCategoriaPorId"; // Actualiza el baseUri
    final uri = Uri.parse("$baseUri/$userId");
    Categoria? user;
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        user = Categoria.fromJson(jsonData);
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
      return null; // Devuelve null en caso de error
    }
    return user;
  }
}