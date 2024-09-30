import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText; // Nueva propiedad para el label
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool isEnabled;
  final bool isObscured;
  final TextInputType? keyboardType;
  final String? errorText; // Nueva propiedad para el mensaje de error

  const CustomTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.isEnabled = true,
    this.isObscured = false,
    this.keyboardType,
    this.errorText, // Inicialización de la nueva propiedad
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) // Solo muestra el label si está definido
          Padding(
            padding: const EdgeInsets.only(
                bottom: 8.0), // Espaciado entre label y campo
            child: Text(
              labelText!,
              style: TextStyle(
                fontWeight: FontWeight
                    .w600, // Ajusta el estilo del label si es necesario
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        TextField(
          controller: controller,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          enabled: isEnabled,
          obscureText: isObscured,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0), // Borde redondeado
              borderSide: BorderSide(
                color: Colors.grey.shade300, // Borde sutil gris claro
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.blue, // Color de borde al enfocar
                width: 1.5,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.grey
                    .shade300, // Borde gris claro cuando está deshabilitado
                width: 1.0,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
            errorText: errorText, // Mensaje de error si lo hay
          ),
        ),
      ],
    );
  }
}
