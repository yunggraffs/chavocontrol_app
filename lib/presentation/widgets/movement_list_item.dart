import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importamos la librería para formateo de moneda
import 'package:chavocontrol_app/models/movimiento.dart';

class MovementListItem extends StatelessWidget {
  final Movimiento movimiento;
  final bool isEditable;

  const MovementListItem({
    super.key,
    required this.movimiento,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Lógica Central: Determinar si es Ingreso o Gasto según el signo del importe
    final bool isIncome = movimiento.importe >= 0;
    final Color arrowColor = isIncome ? Colors.green : Colors.red;
    final IconData arrowIcon = isIncome
        ? Icons.arrow_upward
        : Icons.arrow_downward;

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
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(20.0),
                  // Usar withValues en lugar de withOpacity para evitar deprecation warning
                  color: isIncome
                      ? Colors.green.withValues(alpha: 0.1)
                      :  Colors.green.withValues(alpha: 0.1),
                ),
                child: Icon(arrowIcon, color: arrowColor, size: 24),
              ),             // Flecha: 40px fijo
              const SizedBox(width: 12),  // Espacio: 12px fijo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nombre
                    Text(
                      movimiento.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    // Fecha
                    Text(
                      dateText,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),              // Nombre: El espacio restante
              const SizedBox(width: 8),   // Espacio: 8px fijo
              Text(
                amountText,
                // Usa el importe formateado, con el signo ya incluido
                style: TextStyle(
                  color: arrowColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),                  // Importe: Se adapta
              if (isEditable)
                SizedBox(width: 8,),      // Espacio: 8px fijo
              if (isEditable)
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: Colors.black),
                  onPressed: () {
                    // Lógica para mostrar opciones de editar/eliminar
                  },
                  constraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ), // Le damos un tamaño mínimo decente
                ),          // Botón: ~40px fijo
            ],
          ),
        ),
      ),
    );
  }
}
