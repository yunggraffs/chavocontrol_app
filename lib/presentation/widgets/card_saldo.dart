import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Asumo que AppColors está en esta ruta, ajústala si es necesario
// import 'package:chavocontrol_app/config/app_colors.dart';

class CardSaldo extends StatelessWidget {
  final double saldo;

  const CardSaldo({super.key, required this.saldo});

  @override
  Widget build(BuildContext context) {
    // Formato de moneda
    final currencyFormatter = NumberFormat.currency(
      locale: 'es_ES',
      symbol: '€',
      decimalDigits: 2,
    );
    final String saldoFormatted = currencyFormatter.format(saldo);

    // Color del saldo: Verde si es positivo, Rojo si es negativo
    final Color saldoColor = saldo >= 0 ? Colors.green.shade800 : Colors.red.shade800;

    return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: Colors.black,
          width: 1.5,
        ),
      ),
      color: Colors.white,

      child: Container(
        height: 120,
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "SALDO ACTUAL",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              saldoFormatted,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: saldoColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}