import 'package:chavocontrol_app/config/app_colors.dart';
import 'package:chavocontrol_app/models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color _campoFondo = Color(0x80FFFFFF); // Fondo sutilmente oscuro
const Color _campoBorde = Colors.black; // Borde claro
const Color _campoTexto = Colors.black; // Texto principal
const Color _campoIconos = AppColors.primaryTopBottom; // Iconos
const Color _campoResaltado =
    AppColors.primaryTopBottom; // Color al estar enfocado
const Color _cursorColor = AppColors.primaryTopBottom; // Color del cursor
const Color _botonesTexto =
    AppColors.primaryTopBottom; // Color del texto del botón de 'Cancelar'
const Color _botonPrincipal =
    AppColors.primaryTopBottom; // Color principal del botón de 'Guardar'

class MovimientoFormModal extends StatefulWidget {
  final List<Categoria> categoriasDisponibles;

  const MovimientoFormModal({super.key, required this.categoriasDisponibles});

  @override
  State<MovimientoFormModal> createState() => _MovimientoFormModalState();
}

class _MovimientoFormModalState extends State<MovimientoFormModal> {
  // Variables de estado solo para la parte visual interactiva
  DateTime _fecha = DateTime.now();
  List<Categoria> _categoriasSeleccionadas = [];

  // Selector de fecha
  Future<void> _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fecha,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: const Locale("es", "ES"),
      helpText: "Selecciona la fecha",
      cancelText: "Cancelar",
      confirmText: "Aceptar",
    );

    if (picked != null) {
      setState(() {
        _fecha = picked;
      });
    }
  }

  // Modal de selección de categorias
  Future<void> _seleccionarCategorias() async {
    List<Categoria> tempSeleccionadas = List.from(_categoriasSeleccionadas);

    final resultado = await showDialog<List<Categoria>>(
      context: context,
      builder: (BuildContext dialogContext) { // Usamos dialogContext para el Theme.of
        // 1. Aplicamos un Theme al AlertDialog
        return Theme(
          // Heredamos el tema principal y lo modificamos para el AlertDialog
          data: Theme.of(dialogContext).copyWith(
            // Color de los Checkbox, RadioButtons, etc. (usa el color de resaltado)
            checkboxTheme: CheckboxThemeData(
              fillColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    // Cuando está seleccionado, el fondo es el color de resaltado (el marrón)
                    return _campoResaltado;
                  }
                  // Cuando NO está seleccionado:
                  // Retornamos null para que el cuadrado sea transparente
                  return null;
                },
              ),
              side: WidgetStateBorderSide.resolveWith(
                    (Set<WidgetState> states) {
                  // Si no está seleccionado (o cualquier otro estado que no sea error/deshabilitado),
                  // aplicamos un borde negro (_campoBorde).
                  if (!states.contains(WidgetState.selected)) {
                    return const BorderSide(color: _campoBorde, width: 2.0);
                  }
                  return null; // El borde es manejado por el 'fillColor' cuando está seleccionado.
                },
              ),
            ),
            // Estilo de los TextButton dentro del AlertDialog (Cancelar, Limpiar)
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: _botonesTexto,
              ),
            ),
            // Estilo del ElevatedButton (Aceptar)
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: _botonPrincipal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ),
          child: StatefulBuilder(
            builder: (context, setStateDialog) {
              return AlertDialog(
                // 2. Aplicamos colores al AlertDialog
                backgroundColor: AppColors.primary, // Fondo sutilmente oscuro
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: _campoBorde, width: 1), // Borde negro
                ),
                title: const Text(
                  "Seleccionar Categorías",
                  style: TextStyle(color: _campoTexto, fontWeight: FontWeight.bold),
                ),
                content: SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.categoriasDisponibles.length,
                    itemBuilder: (context, index) {
                      final categoria = widget.categoriasDisponibles[index];
                      final isSelected = tempSeleccionadas.contains(categoria);

                      return CheckboxListTile(
                        // 3. Aplicamos color al texto de las opciones
                        title: Text(
                          categoria.nombre,
                          style: const TextStyle(color: _campoTexto),
                        ),
                        value: isSelected,
                        onChanged: (bool? value) {
                          setStateDialog(() {
                            if (value == true) {
                              tempSeleccionadas.add(categoria);
                            } else {
                              tempSeleccionadas.remove(categoria);
                            }
                          });
                        },
                        checkColor: Colors.white,
                      );
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(null),
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () {
                      setStateDialog(() {
                        tempSeleccionadas.clear();
                      });
                    },
                    child: const Text("Limpiar"),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(tempSeleccionadas),
                    child: const Text("Aceptar"),
                  ),
                ],
              );
            },
          ),
        );
      },
    );

    if (resultado != null) {
      setState(() {
        _categoriasSeleccionadas = resultado;
      });
    }
  }

  // Chips de categorias seleccionadas
  Widget _buildCategoriasChips() {
    if (_categoriasSeleccionadas.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          "No hay categorías seleccionadas",
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: _categoriasSeleccionadas.map((categoria) {
        return Chip(
          label: Text(categoria.nombre),
          deleteIcon: const Icon(Icons.close, size: 18),
          onDeleted: () {
            setState(() {
              _categoriasSeleccionadas.remove(categoria);
            });
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Definición del estilo de Input para los campos de texto
    final inputDecorationTheme = InputDecorationTheme(
      // Color de fondo del campo
      filled: true,
      fillColor: _campoFondo,

      // Borde del campo
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: _campoBorde, width: 1),
      ),

      // Borde cuando está seleccionado (enfocado)
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: _campoResaltado, width: 2),
      ),

      // Borde cuando no está habilitado
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: _campoBorde, width: 1),
      ),

      // Color de los iconos del campo (prefixIcon, suffixIcon)
      prefixIconColor: _campoIconos,
      suffixIconColor: _campoIconos,

      // Color del texto del campo (labelText, hintText, helperText)
      labelStyle: const TextStyle(color: _campoTexto),
      hintStyle: TextStyle(color: _campoTexto.withValues(alpha: 0.6)),
      helperStyle: TextStyle(color: _campoTexto.withValues(alpha: 0.6)),

      // 5. Color resaltado (del labelText) cuando está enfocado
      floatingLabelStyle: TextStyle(
        color: _campoResaltado,
        fontWeight: FontWeight.bold,
      ),
    );

    return Dialog(
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 16,
      // Aplicamos el Theme al contenido del modal
      child: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: inputDecorationTheme,

          textSelectionTheme: TextSelectionThemeData(
            cursorColor: _cursorColor,
            selectionColor: _cursorColor.withValues(alpha: 0.4),
            selectionHandleColor: _cursorColor,
          ),

          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: _botonesTexto),
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: _botonPrincipal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Nuevo Movimiento",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _campoTexto,
                      ),
                    ),
                  ],
                ),

                // Campo: Nombre
                TextFormField(
                  style: const TextStyle(color: _campoTexto),
                  decoration: const InputDecoration(
                    labelText: 'Nombre *',
                    hintText: 'Ej: Compra supermercado',
                    prefixIcon: Icon(Icons.label),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),

                const SizedBox(height: 16),

                // Campo: Importe
                TextFormField(
                  style: const TextStyle(color: _campoTexto),
                  decoration: const InputDecoration(
                    labelText: 'Importe *',
                    hintText: '0.00',
                    prefixIcon: Icon(Icons.euro),
                    suffixText: '€',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^-?\d*\.?\d{0,2}'),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Campo: Fecha (con DatePicker funcional)
                InkWell(
                  onTap: _seleccionarFecha,
                  borderRadius: BorderRadius.circular(4),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Fecha *',
                      prefixIcon: Icon(Icons.calendar_today),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    child: Text(
                      '${_fecha.day.toString().padLeft(2, '0')}/${_fecha.month.toString().padLeft(2, '0')}/${_fecha.year}',
                      style: const TextStyle(fontSize: 16, color: _campoTexto),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Campo: Categorías (con selector funcional)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: _seleccionarCategorias,
                      borderRadius: BorderRadius.circular(4),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Categorías',
                          prefixIcon: Icon(Icons.category),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                        ),
                        child: Text(
                          _categoriasSeleccionadas.isEmpty
                              ? 'Seleccionar categorías'
                              : '${_categoriasSeleccionadas.length} seleccionada(s)',
                          style: TextStyle(
                            fontSize: 16,
                            color: _categoriasSeleccionadas.isEmpty
                                ? _campoTexto.withValues(alpha: 0.6)
                                : _campoTexto,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildCategoriasChips(),
                  ],
                ),

                const SizedBox(height: 16),

                // Campo: Descripción
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    hintText: 'Información adicional...',
                    prefixIcon: Icon(Icons.notes),
                    helperText: 'Opcional',
                  ),
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                ),

                const SizedBox(height: 24),

                // Botones de acción
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Por ahora solo cierra el modal
                        // TODO: Implementar guardado cuando tengamos backend
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Guardar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
