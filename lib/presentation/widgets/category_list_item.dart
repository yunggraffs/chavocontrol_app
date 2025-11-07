import 'package:flutter/material.dart';
import 'package:chavocontrol_app/models/categoria.dart';

class CategoryListItem extends StatelessWidget {
  final Categoria categoria;

  const CategoryListItem({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Container(
        //Contenedor para simular el borde negro
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),

        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoria.nombre,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              IconButton(
                icon: const Icon(Icons.more_horiz, color: Colors.black),
                onPressed: () {
                  // Lógica para mostrar opciones de editar/eliminar
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
