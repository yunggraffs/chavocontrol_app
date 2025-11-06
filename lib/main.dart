import 'package:chavocontrol_app/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  // Se elimina el ChangeNotifierProvider
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChavoControl',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}