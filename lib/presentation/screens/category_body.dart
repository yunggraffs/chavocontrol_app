import 'package:flutter/material.dart';
import 'package:chavocontrol_app/data/database/fake_data.dart';
import 'package:chavocontrol_app/presentation/widgets/category_search_bar.dart';
import 'package:chavocontrol_app/presentation/widgets/category_list_item.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody(
    {super.key}
  );

  static const double borderRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    final categorias = FakeData.kFakeCategorias;

    return Container(
      padding: const EdgeInsets.all(8.0),
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
              // 3. Barra de Búsqueda
              const CategorySearchBar(),

              // 4. ZONA SCROLLABLE (Lista de Categorías)
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
        ),
      ),
    );
  }
}