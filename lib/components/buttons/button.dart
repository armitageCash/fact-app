import 'package:flutter/material.dart';
import 'package:fact_app/shared/styles.dart';

class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final bool isEnabled;

  const Button({
    Key? key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return TailwindColors
                  .neutral500; // Color neutral para estado deshabilitado
            }
            return TailwindColors
                .primary500; // Color primario cuando está habilitado
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.white; // Texto blanco cuando está deshabilitado
            }
            return Colors.white; // Texto blanco cuando está habilitado
          },
        ),
      ),
      onPressed: isEnabled && !isLoading ? onPressed : null,
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.white,
              ),
            )
          : Text(label),
    );
  }
}
