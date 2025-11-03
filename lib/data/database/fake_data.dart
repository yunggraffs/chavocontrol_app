import 'package:chavocontrol_app/models/categoria.dart';

class FakeData {

  // Atributos
  List<Categoria> kFakeCategorias = [
    Categoria(id: 1, nombre: "Comida"),
    Categoria(id: 2, nombre: "Tranasporte"),
    Categoria(id: 3, nombre: "Hogar"),
    Categoria(id: 4, nombre: "Facturas"),
    Categoria(id: 5, nombre: "Ingresos"),
  ];

  List<Movimiento> kFrakeMovimientos = [
    Movimiento(
        id: 1,
        nombre: "Mercadona",
        importe: -100,
        descripcion: null,
        fecha: DateTime.now(),
        categorias: ["Comida"]
    ),
    Movimiento(
        id: 2,
        nombre: "Tren",
        importe: -18,35,
        descripcion: "Tren a Barcelona",
        fecha: DateTime.now(),
        categorias: ["Transporte"]
    ),
    Movimiento(
        id: 3,
        nombre: "Nómina",
        importe: 1432,55,
        descripcion: null,
        fecha: DateTime.now(),
        categorias: ["Ingresos"]
    ),
    Movimiento(
        id: 4,
        nombre: "Luz",
        importe: 120,
        descripcion: "Factura de la Luz",
        fecha: DateTime.now(),
        categorias: ["Hogar", "Facturas"]
    ),
  ];
}