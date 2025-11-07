import 'package:flutter/material.dart';

// NOTE: Se elimina el import de 'package:provider/provider.dart'
import 'package:chavocontrol_app/presentation/widgets/card_saldo.dart';
import 'package:chavocontrol_app/presentation/widgets/movement_list_item.dart';
import 'package:chavocontrol_app/data/database/fake_data.dart';

import '../../config/app_colors.dart'; // Importa la data

class MainBody extends StatelessWidget {
  const MainBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener la lista de movimientos y calcular el saldo (ACCESO ESTÁTICO)
    final List movimientos = FakeData.kFakeMovimientos;
    final double saldoTotal = FakeData.getSaldoTotal();

    // Contenedor exterior para definir el borde.
    return Container(
      color: AppColors.containerBackground,
      child: Column(
        children: [
          // Pasamos el saldo total al CardSaldo
          CardSaldo(saldo: saldoTotal),

          // ZONA SCROLLABLE
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                final movimiento = movimientos[index];
                return MovementListItem(movimiento: movimiento, isEditable: false,);
              },
            ),
          ),
        ],
      ),
    );
  }
}
