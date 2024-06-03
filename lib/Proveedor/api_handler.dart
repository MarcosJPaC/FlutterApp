import 'dart:convert';

import 'package:flutter_web_api/Proveedor/model.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUri = "https://10.0.2.2:7267/api/Venta/GetTodasLasVentas";

  Future<List<Proveedor>> getUserData() async {
    List<Proveedor> data = [];

    final uri = Uri.parse(
        "https://10.0.2.2:7267/api/Proveedor/GetTodasLosProveedores");
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
            .map((json) => Proveedor.fromJson(json))
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
      {required int userId, required Proveedor user}) async {
    final uri = Uri.parse(
        "https://10.0.2.2:7267/api/Proveedor/ActualizarProveedor/Update/$userId?nombre=${Uri
            .encodeComponent(user.nombre)}&direccion=${Uri.encodeComponent(
            user.direccion)}&telefono=${Uri.encodeComponent(user.direccion)}");
    //https://localhost:7267/api/Proveedor/ActualizarProveedor/Update/1?nombre=23&direccion=23&telefono=31
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


  Future<http.Response> addUser({required Proveedor user}) async {
    final uri = Uri.parse(
        "https://10.0.2.2:7267/api/Proveedor/CrearProveedor/Create?"
        //https://localhost:7267/api/Proveedor/CrearProveedor/Create?nombre=21&direccion=21&telefono=21&status=true
            "nombre=${Uri.encodeComponent(user.nombre)}&"
            "direccion=${Uri.encodeComponent(user.direccion.toString())}&"
            "telefono=${Uri.encodeComponent(user.telefono)}"
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
        "https://10.0.2.2:7267/api/Proveedor/EliminarProveedor/Delete/$userId");
    //https://localhost:7267/api/Venta/EliminarVenta/Delete/1
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


  Future<Proveedor?> getUserById({required int userId}) async {
    final uri = Uri.parse(
        "https://10.0.2.2:7267/api/Proveedor/GetProveedorPorId/$userId");
    Proveedor? user;
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 404) {
        return null; // Devuelve null si el usuario no se encuentra
      }

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        user = Proveedor.fromJson(jsonData);
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
      return null;
    }
    return user;
  }

}