import 'package:flutter/material.dart';

class Modal {
  // Método estático para mostrar el modal
  static void showModal({
    required BuildContext context,
    required String title,
    required String OkText,
    required String Canceltext,
    required Widget content,
    required VoidCallback onOk,
    required VoidCallback onCancel,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed: () {
                onCancel(); // Acción de cancelar
                Navigator.of(context).pop(); // Cierra el modal
              },
              child: Text(Canceltext.isEmpty ? "Cancelar" : Canceltext),
            ),
            ElevatedButton(
              onPressed: () {
                onOk(); // Acción de aceptar
                Navigator.of(context).pop(); // Cierra el modal
              },
              child: Text(OkText.isEmpty ? "OK" : OkText),
            ),
          ],
        );
      },
    );
  }
}
