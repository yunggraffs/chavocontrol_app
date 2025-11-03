import 'package:intl/intl.dart';
import 'categoria.dart';

class Movimiento {

  // Atributos
  final int? movimientoId;
  final String nombre;
  final double importe;
  final String? descripcion;
  final DateTime fecha;
  final List<Categoria> categorias;

  // Constructor con ID
  const Movimiento({
    this.movimientoId,
    required this.nombre,
    required this.importe,
    required this.descripcion,
    required this.fecha,
    required this.categorias
  });

  /// Devuelve una representación en forma de cadena de todos los atributos.
  @override
  String toString() {
    // Usamos la interpolación de strings de Dart
    return 'Movimiento(movimientoId: $movimientoId, nombre: $nombre, '
        'importe: $importe, descripcion: $descripcion, '
        'fecha: $fecha, categorias: ${categorias.length})';
  }
}