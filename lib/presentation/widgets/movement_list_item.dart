import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importamos la librería para formateo de moneda
import 'package:chavocontrol_app/models/movimiento.dart';

import '../../config/app_colors.dart';

class MovementListItem extends StatelessWidget {
  final Movimiento movimiento;

  const MovementListItem({super.key, required this.movimiento});

  @override
  Widget build(BuildContext context) {
    // 1. Lógica Central: Determinar si es Ingreso o Gasto según el signo del importe
    final bool isIncome = movimiento.importe >= 0;
    final Color arrowColor = isIncome ? Colors.green : Colors.red;
    final IconData arrowIcon = isIncome ? Icons.arrow_upward : Icons.arrow_downward;

    // 2. Formateo de Moneda: Usamos NumberFormat de la librería intl
    // Esto asegura el formato de decimales y el símbolo € correcto
    final currencyFormatter = NumberFormat.currency(
      locale: 'es_ES', // Puedes cambiar esto según el idioma de tu app
      symbol: '€',
      decimalDigits: 2,
    );

    // Formatea el importe con el signo y el símbolo de moneda
    // Usamos el importe tal cual (incluyendo el signo) para que el formateador lo maneje
    final String amountText = currencyFormatter.format(movimiento.importe);

    // 3. Formateo de Fecha (Opcional, pero útil)
    final String dateText = DateFormat('dd/MM/yyyy').format(movimiento.fecha);


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Container(
        // Contenedor para simular el borde negro alrededor del item
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // --- PARTE IZQUIERDA: Flecha + Nombre ---
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Contenedor de la Flecha
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(20.0),
                      // Usar withAlpha en lugar de withOpacity para evitar deprecation warning
                      color: isIncome ? Colors.green.withAlpha(255 * 0.1 ~/ 1) : Colors.red.withAlpha(255 * 0.1 ~/ 1),
                    ),
                    child: Icon(arrowIcon, color: arrowColor, size: 24),
                  ),

                  const SizedBox(width: 12),

                  // Nombre del movimiento (y opcionalmente la fecha en una columna)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movimiento.nombre,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      // Opcional: Mostrar la fecha debajo del nombre
                      Text(
                        dateText,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),

              // --- PARTE DERECHA: Importe + Opciones ---
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Importe del movimiento
                  Text(
                    amountText, // Usa el importe formateado, con el signo ya incluido
                    style: TextStyle(
                      color: arrowColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  // AÑADIMOS ESTE ESPACIO PARA SEPARAR EL IMPORTE DEL BOTÓN
                  const SizedBox(width: 8.0), // <-- AUMENTA ESTE VALOR PARA MÁS SEPARACIÓN

                  // Botón de opciones (3 puntos)
                  IconButton(
                    icon: const Icon(Icons.more_horiz, color: Colors.black),
                    onPressed: () {
                      // Lógica para mostrar opciones de editar/eliminar
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 40, minHeight: 40), // Le damos un tamaño mínimo decente
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}