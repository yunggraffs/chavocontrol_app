import 'package:chavocontrol_app/models/categoria.dart';
import 'package:chavocontrol_app/models/movimiento.dart';

class FakeData {
  // Categorías
  static final List<Categoria> kFakeCategorias = [
    Categoria(id: 1, nombre: "Comida"),
    Categoria(id: 2, nombre: "Transporte"),
    Categoria(id: 3, nombre: "Hogar"),
    Categoria(id: 4, nombre: "Facturas"),
    Categoria(id: 5, nombre: "Ingresos"),
  ];

  // Movimientos ORDENADOS POR FECHA (más nuevo primero)
  static final List<Movimiento> kFakeMovimientos = [
    // 1. Nómina (Ingreso - Hoy)
    Movimiento(
      movimientoId: 3,
      nombre: "Nómina",
      importe: 1432.55,
      descripcion: "Sueldo mensual",
      fecha: DateTime.now(),
      categorias: [kFakeCategorias[4]],
    ),

    // 2. Tren (Gasto - Hace 1 día)
    Movimiento(
      movimientoId: 2,
      nombre: "Tren",
      importe: -18.35,
      descripcion: "Tren a Barcelona",
      fecha: DateTime.now().subtract(const Duration(days: 1)),
      categorias: [kFakeCategorias[1]],
    ),

    // 3. Mercadona (Gasto - Hace 2 días)
    Movimiento(
      movimientoId: 1,
      nombre: "Mercadona",
      importe: -100.00,
      descripcion: "Compra semanal de alimentos",
      fecha: DateTime.now().subtract(const Duration(days: 2)),
      categorias: [kFakeCategorias[0]],
    ),

    // 4. Luz (Gasto - Hace 3 días)
    Movimiento(
      movimientoId: 4,
      nombre: "Luz",
      importe: -120.00,
      descripcion: "Factura de la Luz",
      fecha: DateTime.now().subtract(const Duration(days: 3)),
      categorias: [kFakeCategorias[3], kFakeCategorias[2]],
    ),

    // 5. Gasolina (Gasto - Hace 4 días)
    Movimiento(
      movimientoId: 7,
      nombre: "Gasolina",
      importe: -65.00,
      descripcion: "Llenado de depósito",
      fecha: DateTime.now().subtract(const Duration(days: 4)),
      categorias: [kFakeCategorias[1]],
    ),

    // 6. Cena Restaurante (Gasto - Hace 5 días)
    Movimiento(
      movimientoId: 5,
      nombre: "Cena",
      importe: -45.70,
      descripcion: "Sushi con amigos",
      fecha: DateTime.now().subtract(const Duration(days: 5)),
      categorias: [kFakeCategorias[0]],
    ),

    // 7. Bizum Amigo (Ingreso - Hace 6 días)
    Movimiento(
      movimientoId: 8,
      nombre: "Bizum Amigo",
      importe: 30.00,
      descripcion: "Devolución de entradas de cine",
      fecha: DateTime.now().subtract(const Duration(days: 6)),
      categorias: [kFakeCategorias[4]],
    ),

    // 8. Netflix (Gasto - Hace 7 días)
    Movimiento(
      movimientoId: 10,
      nombre: "Netflix",
      importe: -12.99,
      descripcion: "Suscripción mensual",
      fecha: DateTime.now().subtract(const Duration(days: 7)),
      categorias: [kFakeCategorias[3]],
    ),

    // 9. Móvil (Gasto - Hace 10 días)
    Movimiento(
      movimientoId: 6,
      nombre: "Móvil",
      importe: -35.90,
      descripcion: "Factura de fibra y móvil",
      fecha: DateTime.now().subtract(const Duration(days: 10)),
      categorias: [kFakeCategorias[3]],
    ),

    // 10. Alquiler (Gasto - Hace 15 días)
    Movimiento(
      movimientoId: 9,
      nombre: "Alquiler",
      importe: -750.00,
      descripcion: "Pago mensual de vivienda",
      fecha: DateTime.now().subtract(const Duration(days: 15)),
      categorias: [kFakeCategorias[2], kFakeCategorias[3]],
    ),
  ];

  // Calcula el saldo total sumando todos los importes de los movimientos.
  static double getSaldoTotal() {
    return kFakeMovimientos.fold(0.0, (sum, item) => sum + item.importe);
  }
}
