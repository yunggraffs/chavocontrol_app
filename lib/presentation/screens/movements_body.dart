import 'package:chavocontrol_app/data/database/fake_data.dart';
import 'package:chavocontrol_app/models/movimiento.dart';
import 'package:chavocontrol_app/presentation/widgets/category_search_bar.dart';
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../widgets/movement_list_item.dart';

class MovementsBody extends StatelessWidget {
  const MovementsBody({super.key});

  static const double borderRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    final List<Movimiento> movimientos = FakeData.kFakeMovimientos;

    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          color: AppColors.containerBackground,
          child: Column(
            children: [
              // Barra de busqueda
              const CategorySearchBar(),

              // Lista de movimientos
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
