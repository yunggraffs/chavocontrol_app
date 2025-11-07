import 'package:flutter/material.dart';

class CategorySearchBar extends StatelessWidget {
  const CategorySearchBar(
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),

      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),

      child: TextField(
        decoration: InputDecoration(
          hintText: "Buscar categoría...",
          hintStyle: const TextStyle(color: Colors.black54),
          border: InputBorder.none,

          suffixIcon: Container(
            padding: const EdgeInsets.only(left: 8.0),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.black, width: 1.0),
              ),
            ),

            child: const Icon(
              Icons.search,
              color: Colors.black,
              size: 24,
            ),
          ),
        ),
        onChanged: (value) {
          // Lógica futura para filtrar la lista de categorías (requiere State Management)
        },
      )
    );
  }
}