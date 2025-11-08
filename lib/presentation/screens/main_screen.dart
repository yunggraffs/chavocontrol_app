import 'package:chavocontrol_app/presentation/screens/category_body.dart';
import 'package:chavocontrol_app/presentation/screens/movements_body.dart';
import 'package:chavocontrol_app/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';
import 'main_body.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Estado para rastrear la página seleccionada

  final List<Widget> _pages = const <Widget>[
    MainBody(),                                                                    // Índice 0: Home
    MovementsBody(),                                                               // Índice 1: Movimientos
    CategoryBody(),                                                                // Índice 2: Categorías
    _PlaceholderScreen(title: 'Perfil de Usuario', color: Colors.deepPurple),      // Índice 3: Perfil
  ];

  // Función para manejar el toque del ítem y actualizar el estado
  void _onItemTapped(int index) {
    if (index >= 0 && index < _pages.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
    // NOTA: El botón central NO llama a esta función
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  final Color color;

  const _PlaceholderScreen({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}