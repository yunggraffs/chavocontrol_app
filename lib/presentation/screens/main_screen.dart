import 'package:chavocontrol_app/config/app_colors.dart';
import 'package:chavocontrol_app/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Estado para rastrear la página seleccionada

  // Lista de Widgets (Páginas) que se mostrarán en el cuerpo del Scaffold.
  final List<Widget> _pages = const <Widget>[
    _PlaceholderScreen(title: 'Inicio', color: AppColors.primary),              // Índice 0: Home
    _PlaceholderScreen(title: 'Lista de Movimientos', color: Colors.blueGrey),  // Índice 1: Movimientos (Lateral)
    _PlaceholderScreen(title: 'Crear Movimiento', color: Colors.green),         // Índice 2: Acción Movimiento (Central Action)
    _PlaceholderScreen(title: 'Lista de Categorías', color: Colors.teal),       // Índice 3: Categorías (Lateral)
    _PlaceholderScreen(title: 'Perfil de Usuario', color: Colors.deepPurple),   // Índice 4: Perfil
  ];

  // Función para manejar el toque del ítem y actualizar el estado
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: _pages[_selectedIndex],
      // Aquí está la integración del CustomBottomNavigationBar
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