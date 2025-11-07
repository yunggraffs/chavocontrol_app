import 'package:chavocontrol_app/models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MovimientoFormModal extends StatefulWidget {
  final List<Categoria> categoriasDisponibles;

  const MovimientoFormModal({Key? key, required this.categoriasDisponibles})
      : super(key: key);

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
        builder: (BuildContext) {
          return StatefulBuilder(
              builder: (context, setStateDialog) {
                return AlertDialog(
                  title: const Text("Seleccionar Categorías"),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.categoriasDisponibles.length,
                      itemBuilder: (context, index) {
                        final categoria = widget.categoriasDisponibles[index];
                        final isSelected = tempSeleccionadas.contains(
                            categoria);

                        return CheckboxListTile(
                          title: Text(categoria.nombre),
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
          style: TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 16,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 500,
          maxHeight: 700,
        ),
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
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: "Cerrar",
                  ),
                ],
              ),

              // Campo: Nombre
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nombre *',
                  hintText: 'Ej: Compra supermercado',
                  prefixIcon: Icon(Icons.label),
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.sentences,
              ),

              const SizedBox(height: 16),

              // Campo: Importe
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Importe *',
                  hintText: '0.00',
                  prefixIcon: Icon(Icons.euro),
                  suffixText: '€',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d{0,2}')),
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
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                  child: Text(
                    '${_fecha.day.toString().padLeft(2, '0')}/${_fecha.month.toString().padLeft(2, '0')}/${_fecha.year}',
                    style: const TextStyle(fontSize: 16),
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
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                      child: Text(
                        _categoriasSeleccionadas.isEmpty
                            ? 'Seleccionar categorías'
                            : '${_categoriasSeleccionadas.length} seleccionada(s)',
                        style: TextStyle(
                          fontSize: 16,
                          color: _categoriasSeleccionadas.isEmpty
                              ? Colors.grey.shade600
                              : Colors.black87,
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
                  border: OutlineInputBorder(),
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
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


