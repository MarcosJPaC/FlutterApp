class Empleado {
  final int idEmpleado;
  final String nombre;
  final String puesto;
  final int salario;
  final int status;

  const Empleado({
    required this.idEmpleado,
    required this.nombre,
    required this.puesto,
    required this.salario,
    required this.status
  });

  const Empleado.empty({
    this.idEmpleado = 0,
    this.nombre = '',
    this.puesto = '',
    this.salario = 0,
    this.status = 0
  });

  factory Empleado.fromJson(Map<String, dynamic> json) => Empleado(
      idEmpleado: json['idEmpleado'],
      nombre: json['nombre'],
      puesto: json['puesto'],
      salario: json['salario'],
      status: json['status']

  );
  Map<String,dynamic> toJson() => {
    "idEmpleado":idEmpleado,
    "nombre":nombre,
    "puesto":puesto,
    "salrio":salario,
    "status":status
  };
}
