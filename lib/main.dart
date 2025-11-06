import 'package:chavocontrol_app/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
// NOTE: Se elimina el import de 'package:provider/provider.dart'
// NOTE: Se elimina el import de 'package:chavocontrol_app/data/database/fake_data.dart'

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