import 'package:chavocontrol_app/config/app_colors.dart';
import 'package:flutter/material.dart';

// Se implementa PreferredSizeWidget para que el Scaffold lo pueda usar como AppBar
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  // Propiedad requerida: Define la altura total de la AppBar
  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    // Obtener el ancho de la pantalla
    final double screenWith = MediaQuery
        .of(context)
        .size
        .width;
    // Definir el ancho de las tres columnas
    final double columnWith = screenWith / 3;

    return Container(
      color: AppColors.primaryTopBottom,
      // SafeArea para no solapar la barra de notificaciones
      child: SafeArea(
        child: Row(
          children: <Widget>[

            // Icono de menú
            SizedBox(
              width: columnWith,
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                      Icons.menu_rounded,
                      color: AppColors.primary,
                      size: 40
                  ),
                ),
              ),
            ),

            // Imagen de la app
            SizedBox(
              width: columnWith,
              child: Center(
                child: Image.asset(
                  "assets/images/Icon_ChavoControlT.png",
                  width: 50,
                ),
              ),
            ),

            // Botón de perfil
            SizedBox(
              width: columnWith,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white30,
                    child: Icon(
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
