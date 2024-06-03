class Categoria {
  final int idCategoria;
  final String nombre;
  final String descripcion;
  final String estado;
  final int status;

  const Categoria({
    required this.idCategoria,
    required this.nombre,
    required this.descripcion,
    required this.estado,
    required this.status
  });

  const Categoria.empty({
    this.idCategoria = 0,
    this.nombre = '',
    this.descripcion = '',
    this.estado = '',
    this.status = 0
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
      idCategoria: json['idCategoria'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      status: json['status']

  );
  Map<String,dynamic> toJson() => {
    "idCategoria":idCategoria,
    "nombre":nombre,
    "descripcion":descripcion,
    "estado":estado,
    "status":status
  };
}
