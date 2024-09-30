import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha

class CustomDatePicker extends StatelessWidget {
  final String? labelText; // El label que se mostrará encima del campo de fecha
  final DateTime? selectedDate; // La fecha seleccionada actualmente
  final ValueChanged<DateTime?>?
      onChanged; // Evento para manejar el cambio de fecha
  final bool isEnabled; // Si el selector de fecha está habilitado o no

  const CustomDatePicker({
    Key? key,
    this.labelText,
    this.selectedDate,
    this.onChanged,
    this.isEnabled = true, // Por defecto el selector está habilitado
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(), // Fecha inicial en el picker
      firstDate: DateTime(2000), // Fecha mínima
      lastDate: DateTime(2101), // Fecha máxima
    );
    if (pickedDate != null && onChanged != null) {
      onChanged!(pickedDate); // Actualiza el estado si se selecciona una fecha
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              labelText!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
        GestureDetector(
          onTap: isEnabled ? () => _selectDate(context) : null,
          child: AbsorbPointer(
            child: TextField(
              decoration: InputDecoration(
                hintText: selectedDate != null
                    ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                    : 'Selecciona una fecha',
                enabled: isEnabled,
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.calendar_today),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
