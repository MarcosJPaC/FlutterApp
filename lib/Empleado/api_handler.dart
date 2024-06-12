import 'dart:convert';

import 'package:flutter_web_api/Empleado/model.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUri = "https://10.0.2.2:7267/api/Empleado/GetTodosLosEmpleados";

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

        // Filtrar los registros con status igual a 0
        data = jsonData
            .map((json) => Empleado.fromJson(json))
            .where((empleado) => empleado.status == 1)
            .toList();
      }
    } catch (e) {
      // Manejar cualquier error y devolver una lista vacía en caso de error
      return data;
    }

    return data;
  }

  Future<http.Response> updateUser(
      {required int userId, required Empleado user}) async {
    final uri = Uri.parse(
        "https://10.0.2.2:7267/api/Empleado/ActualizarEmpleado/Update/$userId?nombre=${Uri
            .encodeComponent(user.nombre)}&puesto=${Uri.encodeComponent(
            user.puesto)}&salario=${Uri.encodeComponent(
            user.salario.toString())}");

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




  Future<http.Response> addUser({required Empleado user}) async {
    final uri = Uri.parse(
        "https://10.0.2.2:7267/api/Empleado/CrearEmpleado/Create?"
            "nombre=${Uri.encodeComponent(user.nombre)}&"
            "puesto=${Uri.encodeComponent(user.puesto)}&"
            "salario=${Uri.encodeComponent(user.salario.toString())}&"
            "status=${user.status == 1 ? 'true' : 'false'}"
    );
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
        "https://10.0.2.2:7267/api/Empleado/EliminarCategoria/Delete/$userId");
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


  Future<Empleado?> getUserById({required int userId}) async {
    final uri = Uri.parse(
        "https://10.0.2.2:7267/api/Empleado/GetEmpleadoPorId/$userId");
    Empleado? user;
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 404) {
        return null; // Devuelve null si el empleado no se encuentra
      }

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        user = Empleado.fromJson(jsonData);
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
      return null;
    }
    return user;
  }
}