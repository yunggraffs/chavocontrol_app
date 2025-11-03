import 'package:intl/intl.dart';

class Movimiento {

  // Atributos
  int? movimientoId;
  String nombre;
  double importe;
  String descripcion;
  DateTime fecha;
  //late List<Categoria> categorias;

  // Constructor con ID
  Movimiento({
    required this.movimientoId,
    required this.nombre,
    required this.importe,
    required this.descripcion,
    required this.fecha,
  });

  // Constructor sin ID
  Movimiento.nuevo({
    required this.nombre,
    required this.importe,
    required this.descripcion,
    required this.fecha,
  }) {
    movimientoId = null; // El ID es nulo porque es un objeto nuevo
  }

  /// Devuelve una representación en forma de cadena de todos los atributos.
  @override
  String toString() {
    // Usamos la interpolación de strings de Dart
    return 'Movimiento(movimientoId: $movimientoId, nombre: $nombre, '
        'importe: $importe, descripcion: $descripcion, '
        'fecha: $fecha, categorias: ${categorias.length})';
  }
}