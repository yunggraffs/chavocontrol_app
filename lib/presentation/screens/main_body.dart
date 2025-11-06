import 'package:flutter/material.dart';
// NOTE: Se elimina el import de 'package:provider/provider.dart'
import 'package:chavocontrol_app/presentation/widgets/card_saldo.dart';
import 'package:chavocontrol_app/presentation/widgets/movement_list_item.dart';
import 'package:chavocontrol_app/data/database/fake_data.dart'; // Importa la data

class MainBody extends StatelessWidget {
  const MainBody({super.key});

  static const double borderRadius = 20.0;

  @override
  Widget build(BuildContext context) {

    // 1. Obtener la lista de movimientos y calcular el saldo (ACCESO ESTÁTICO)
    final List movimientos = FakeData.kFakeMovimientos;
    final double saldoTotal = FakeData.getSaldoTotal();

    // 2. Contenedor exterior para definir el borde.
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Colors.black,
          width: 3.0,
        ),
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius - 1),

        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              // 3. Pasamos el saldo total al CardSaldo
              CardSaldo(saldo: saldoTotal),

              // ZONA SCROLLABLE
              Expanded(
                child: ListView.builder(
                  itemCount: movimientos.length,
                  itemBuilder: (context, index) {
                    final movimiento = movimientos[index];
                    return MovementListItem(movimiento: movimiento);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}