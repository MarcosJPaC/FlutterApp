class Empleado {
  final int idCliente;
  final String nombre;
  final String direccion;
  final String telefono;
  final int status;

  const Empleado({
    required this.idCliente,
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.status
  });

  const Empleado.empty({
    this.idCliente = 0,
    this.nombre = '',
    this.direccion = '',
    this.telefono = '',
    this.status = 0
  });

  factory Empleado.fromJson(Map<String, dynamic> json) => Empleado(
      idCliente: json['idCliente'],
      nombre: json['nombre'],
      direccion: json['direccion'],
      telefono: json['telefono'],
      status: json['status']

  );
  Map<String,dynamic> toJson() => {
    "idCliente":idCliente,
    "nombre":nombre,
    "direccion":direccion,
    "telefono":telefono,
    "status":status
  };
}
