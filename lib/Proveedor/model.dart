class Proveedor {
  final int idProveedor;
  final String nombre;
  final String direccion;
  final String telefono;
  final int status;

  const Proveedor({
    required this.idProveedor,
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.status
  });

  const Proveedor.empty({
    this.idProveedor = 0,
    this.nombre = '',
    this.direccion = '',
    this.telefono = '',
    this.status = 0
  });

  factory Proveedor.fromJson(Map<String, dynamic> json) => Proveedor(
      idProveedor: json['idProveedor'],
      nombre: json['nombre'],
      direccion: json['direccion'],
      telefono: json['telefono'],
      status: json['status']

  );
  Map<String,dynamic> toJson() => {
    "idVenta":idProveedor,
    "nombre":nombre,
    "direccion":direccion,
    "telefono":telefono,
    "status":status
  };
}
