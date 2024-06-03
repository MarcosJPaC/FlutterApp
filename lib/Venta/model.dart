class Venta {
  final int idVenta;
  final String fecha;
  final int total;
  final int status;

  const Venta({
    required this.idVenta,
    required this.fecha,
    required this.total,
    required this.status
  });

  const Venta.empty({
    this.idVenta = 0,
    this.fecha = '',
    this.total = 0,
    this.status = 0
  });

  factory Venta.fromJson(Map<String, dynamic> json) => Venta(
      idVenta: json['idVenta'],
      fecha: json['fecha'],
      total: json['total'],
      status: json['status']

  );
  Map<String,dynamic> toJson() => {
    "idVenta":idVenta,
    "fecha":fecha,
    "total":total,
    "status":status
  };
}
