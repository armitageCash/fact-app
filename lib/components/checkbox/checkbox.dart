import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String labelText; // El label que se mostrará junto al checkbox
  final bool value; // El estado actual del checkbox (true o false)
  final ValueChanged<bool?>
      onChanged; // Evento para manejar el cambio de estado
  final bool isEnabled; // Si el checkbox está habilitado o no

  const CustomCheckbox({
    Key? key,
    required this.labelText,
    required this.value,
    required this.onChanged,
    this.isEnabled = true, // Por defecto el checkbox estará habilitado
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: isEnabled
              ? onChanged
              : null, // Si está habilitado, ejecuta el evento onChanged
        ),
        GestureDetector(
          onTap: isEnabled
              ? () {
                  onChanged(
                      !value); // Cambia el valor del checkbox al hacer clic en el label
                }
              : null, // Si no está habilitado, no se podrá hacer clic
          child: Text(
            labelText,
            style: TextStyle(
              fontSize: 16,
              color: isEnabled
                  ? Colors.black
                  : Colors
                      .grey, // Estilo del label cuando está habilitado o deshabilitado
            ),
          ),
        ),
      ],
    );
  }
}
