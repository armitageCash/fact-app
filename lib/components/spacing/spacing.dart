import 'package:flutter/material.dart';

class Spacing extends StatelessWidget {
  final String orientation; // "vertical" o "horizontal"
  final double size; // Tamaño del espacio
  final BoxDecoration? boxDecoration; // Estilos adicionales

  const Spacing({
    Key? key,
    required this.orientation, // Requerido, define la orientación
    required this.size, // Requerido, tamaño del espaciador
    this.boxDecoration, // Opcional, estilo adicional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: orientation == 'vertical'
          ? size
          : null, // Si es vertical, aplica el width
      height: orientation == 'horizontal'
          ? size
          : null, // Si es horizontal, aplica el height
      decoration: boxDecoration, // Aplicar estilos si se proporcionan
    );
  }
}
