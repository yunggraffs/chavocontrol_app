import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

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
  static const Color _barColor = AppColors.primaryTopBottom;

  // Controla la visibilidad del menú flotante al pulsar el botón central.
  bool _isActionMenuVisible = false;

  void _onCentralButtonTapped() {
    setState(() {
      _isActionMenuVisible = !_isActionMenuVisible;
    });
  }

  // Construye los botones de acción Movimiento/Categoría
  Widget _buildActionButton(String text, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            widget.onItemTapped(index);
            setState(() {
              _isActionMenuVisible =
                  false; // Oculta el menú después de la selección
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _barColor, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: _barColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Construye el botón central ADD/CLOSE
  Widget _buildCentralButton() {
    return InkWell(
      onTap: _onCentralButtonTapped,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          // Cambia el ícono a 'X' si el menú está visible
          _isActionMenuVisible ? Icons.close : Icons.add,
          color: Colors.black,
          size: _iconSize,
        ),
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
        setState(() {
          _isActionMenuVisible =
              false; // Cierra el menú al navegar a un ícono lateral
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double safeAreaBottom = MediaQuery.of(context).padding.bottom;
    final double barHeight = kBottomNavigationBarHeight + safeAreaBottom;

    // Se usa Stack para superponer la barra, el menú flotante y el botón central.
    return Container(
      // La altura se ajusta para dar espacio al menú flotante cuando está activo.
      height: barHeight + (_isActionMenuVisible ? 150 : 0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 1. La Barra de Navegación (Base)
          Container(
            height: barHeight,
            color: _barColor,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildLateralButton(Icons.home_outlined, 0),
                  _buildLateralButton(Icons.compare_arrows_sharp, 1),
                  const SizedBox(width: 60), // Espacio para el botón central
                  _buildLateralButton(Icons.label_outline_sharp, 3),
                  _buildLateralButton(Icons.person_outline, 4),
                ],
              ),
            ),
          ),

          // 2. Menú de Acción Flotante (Botones Movimiento y Categoría)
          if (_isActionMenuVisible)
            Positioned(
              bottom: barHeight + 20,
              // Posiciona el menú 20px por encima de la barra
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildActionButton("Movimiento", 2),
                  const SizedBox(width: 20),
                  _buildActionButton("Categoría", 5),
                ],
              ),
            ),

          // 3. Botón Central (Superpuesto)
          Positioned(
            bottom: safeAreaBottom + 5, // Ajuste para centrarlo verticalmente
            child: _buildCentralButton(),
          ),
        ],
      ),
    );
  }
}
