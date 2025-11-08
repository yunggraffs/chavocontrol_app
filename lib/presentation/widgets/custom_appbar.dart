import 'package:chavocontrol_app/config/app_colors.dart';
import 'package:flutter/material.dart';

// Se implementa PreferredSizeWidget para que el Scaffold lo pueda usar como AppBar
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  // Atributos
  static const Color primaryAppBar = Colors.white;
  static const double columnWidth = 70;

  // Propiedad requerida: Define la altura total de la AppBar
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryTopBottom,
      // Aplicamos un SafeArea únicamente arriba
      child: SafeArea(
        bottom: false,
        left: false,
        right: false,
        // Definimos el layout
        child: Row(
          children: <Widget>[
            // ------ Icono de Menú (Izquierda)
            SizedBox(
              width: columnWidth,
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    // Lógica para abrir el menú
                  },
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: primaryAppBar,
                    size: 40,
                  ),
                ),
              ),
            ),

            // ------ Imagen de la App (Centro)
            // 'Expanded' ocupará el espacio sobrante en el medio
            Expanded(
              // 'Center' lo centrará dentro de ese espacio sobrante
              child: Center(
                child: Image.asset(
                  "assets/images/Icon_ChavoControlT.png",
                  width: 50,
                  // Añadimos un fallback por si la imagen no carga
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.shield_moon,
                    size: 50,
                    color: primaryAppBar,
                  ),
                ),
              ),
            ),

            // ------ Botón de Perfil (Derecha)
            // Usamos el mismo ancho fijo que la izquierda para garantizar
            // que el logo 'Expanded' esté perfectamente centrado
            SizedBox(
              width: columnWidth,
              child: Align(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundColor: Colors.white30,
                    child: const Icon(
                      Icons.person,
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
