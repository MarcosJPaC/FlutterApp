import 'dart:ffi';

class Producto {
  final int idProducto;
  final String nombre;
  final String descripcion;
  final double precio;
  final int status;

  const Producto({
    required this.idProducto,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.status
  });

  const Producto.empty({
    this.idProducto = 0,
    this.nombre = '',
    this.descripcion = '',
    this.precio = 0,
    this.status = 0
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
      idProducto: json['idProducto'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precio: json['precio'].toDouble(), // Convertir a double
      status: json['status']
  );

  Map<String,dynamic> toJson() => {
    "idProducto":idProducto,
    "nombre":nombre,
    "descripcion":descripcion,
    "precio":precio,
    "status":status
  };
}
