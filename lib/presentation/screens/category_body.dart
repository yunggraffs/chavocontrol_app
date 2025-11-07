import 'package:flutter/material.dart';
import 'package:chavocontrol_app/data/database/fake_data.dart';
import 'package:chavocontrol_app/presentation/widgets/category_search_bar.dart';
import 'package:chavocontrol_app/presentation/widgets/category_list_item.dart';

import '../../config/app_colors.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody(
    {super.key}
  );

  static const double borderRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    final categorias = FakeData.kFakeCategorias;

    return Container(
      color: AppColors.containerBackground,
      child: Column(
        children: [
          // Barra de Búsqueda
          const CategorySearchBar(),

          // Lista de Categorías
          Expanded(
            child: ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final categoria = categorias[index];
                return CategoryListItem(categoria: categoria);
              },
            ),
          ),
        ],
      ),
    );
  }
}