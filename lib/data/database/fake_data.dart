import 'package:chavocontrol_app/models/categoria.dart';
import 'package:chavocontrol_app/models/movimiento.dart';

class FakeData {

  // Atributos
  static final List<Categoria> kFakeCategorias = [
    Categoria(id: 1, nombre: "Comida"),
    Categoria(id: 2, nombre: "Transporte"),
    Categoria(id: 3, nombre: "Hogar"),
    Categoria(id: 4, nombre: "Facturas"),
    Categoria(id: 5, nombre: "Ingresos"),
  ];

  // La lista debe ser static final para este punto de retorno
  static final List<Movimiento> kFakeMovimientos = [
    Movimiento(
        movimientoId: 1,
        nombre: "Mercadona",
        importe: -100.00,
        descripcion: null,
        fecha: DateTime.now().subtract(const Duration(days: 2)),
        categorias: [kFakeCategorias[0]]
    ),
    Movimiento(
        movimientoId: 2,
        nombre: "Tren",
        importe: -18.35,
        descripcion: "Tren a Barcelona",
        fecha: DateTime.now().subtract(const Duration(days: 1)),
        categorias: [kFakeCategorias[1]]
    ),
    Movimiento(
        movimientoId: 3,
        nombre: "Nómina",
        importe: 1432.55,
        descripcion: null,
        fecha: DateTime.now(),
        categorias: [kFakeCategorias[4]]
    ),
    Movimiento(
        movimientoId: 4,
        nombre: "Luz",
        importe: -120.00,
        descripcion: "Factura de la Luz",
        fecha: DateTime.now().subtract(const Duration(days: 3)),
        categorias: [kFakeCategorias[3], kFakeCategorias[2]]
    ),
    Movimiento(
        movimientoId: 5,
        nombre: "Mercadona",
        importe: -100.00,
        descripcion: null,
        fecha: DateTime.now().subtract(const Duration(days: 2)),
        categorias: [kFakeCategorias[0]]
    ),
    Movimiento(
        movimientoId: 6,
        nombre: "Tren",
        importe: -18.35,
        descripcion: "Tren a Barcelona",
        fecha: DateTime.now().subtract(const Duration(days: 1)),
        categorias: [kFakeCategorias[1]]
    ),
    Movimiento(
        movimientoId: 7,
        nombre: "Nómina",
        importe: 1432.55,
        descripcion: null,
        fecha: DateTime.now(),
        categorias: [kFakeCategorias[4]]
    ),
    Movimiento(
        movimientoId: 8,
        nombre: "Luz",
        importe: -120.00,
        descripcion: "Factura de la Luz",
        fecha: DateTime.now().subtract(const Duration(days: 3)),
        categorias: [kFakeCategorias[3], kFakeCategorias[2]]
    ),
  ];

  /// Calcula el saldo total sumando todos los importes de los movimientos.
  static double getSaldoTotal() {
    return kFakeMovimientos.fold(0.0, (sum, item) => sum + item.importe);
  }
}