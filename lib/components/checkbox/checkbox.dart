import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String labelText; // El label que se mostrará junto al checkbox
  final bool value; // El estado actual del checkbox (true o false)
  final ValueChanged<bool?>
      onChanged; // Evento para manejar el cambio de estado
  final bool isEnabled; // Si el checkbox está habilitado o no
  final String style; // El estilo ('success', 'danger', o ninguno)

  const CustomCheckbox({
    Key? key,
    required this.labelText,
    required this.value,
    required this.onChanged,
    this.isEnabled = true, // Por defecto el checkbox estará habilitado
    this.style = '', // Por defecto no hay estilo
  }) : super(key: key);

  Color _getCheckboxColor() {
    if (!isEnabled) return Colors.grey; // Deshabilitado
    switch (style) {
      case 'success':
        return Colors.green; // Estilo success
      case 'danger':
        return Colors.red; // Estilo danger
      default:
        return Colors.black; // Estilo predeterminado
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor:
                _getCheckboxColor(), // Cambia color del borde
          ),
          child: Checkbox(
            value: value,
            onChanged: isEnabled ? onChanged : null, // Si está habilitado
            activeColor:
                _getCheckboxColor(), // Cambia color del ícono al estar seleccionado
          ),
        ),
        GestureDetector(
          onTap: isEnabled
              ? () {
                  onChanged(
                      !value); // Cambia el valor al hacer clic en el label
                }
              : null,
          child: Text(
            labelText,
            style: TextStyle(
              fontSize: 16,
              color: isEnabled
                  ? _getCheckboxColor()
                  : Colors.grey, // Cambia el color del texto
            ),
          ),
        ),
      ],
    );
  }
}
