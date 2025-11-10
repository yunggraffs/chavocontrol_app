import 'package:chavocontrol_app/data/database/fake_data.dart';
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import 'movimiento_form_modal.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  static const double _iconSize = 33.0;

  // Construye el botón central
  Widget _buildCentralButton() {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return MovimientoFormModal(
              categoriasDisponibles: FakeData.kFakeCategorias,
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black..withValues(alpha: 0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(Icons.add, color: Colors.black, size: _iconSize),
      ),
    );
  }

  // Construye los botones laterales de navegación
  Widget _buildLateralButton(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        // Ícono blanco, se atenúa si no está seleccionado
        color: widget.selectedIndex == index ? Colors.white : Colors.white54,
        size: _iconSize,
      ),
      onPressed: () {
        widget.onItemTapped(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculamos el bottom safe area y la altura del widget
    final double safeAreaBottom = MediaQuery.of(context).padding.bottom;
    final double barHeight = kBottomNavigationBarHeight + safeAreaBottom;

    return Container(
      height: barHeight,
      color: AppColors.primaryTopBottom,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // ------ Icono Home
          Expanded(
            child: _buildLateralButton(Icons.home_outlined, 0),
          ),
          // ------ Icono Movimientos
          Expanded(
            child: _buildLateralButton(Icons.compare_arrows_sharp, 1),
          ),
          // ------ Icono Añadir
          Expanded(
              child: _buildCentralButton()
          ),
          // ------ Icono Categorías
          Expanded(
            child: _buildLateralButton(Icons.label_outline_sharp, 2),
          ),
          // ------ Icono Usuario
          Expanded(
            child: _buildLateralButton(Icons.person_outline, 3),
          ),
        ],
      ),
    );
  }
}
