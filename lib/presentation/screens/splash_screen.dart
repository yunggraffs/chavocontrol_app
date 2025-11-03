import 'package:chavocontrol_app/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Atributo de la ruta de la imagen
  final String logoPath = "assets/images/Icon_ChavoControlT.png";

  // Lógica del temporizador
  @override
  void initState() {
    super.initState();
    // Future.delayed() crea una promesa que se devuelve a los 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      // Comprobar si despues del tiempo el widget sigue montado
      if (!mounted) { return; }
      
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold para la estructura básica del screen
    return Scaffold(
      // Container como body para poder darle el color
      body: Container(
        color: AppColors.primary,
        // Center para asegurarnos que el child está centrado en la pantalla
        child: Center(
          child: Image.asset(
            logoPath,
            width: 150,
            height: 150,
            // Asegura que la imagen se ajusta bien sin deformarse
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}