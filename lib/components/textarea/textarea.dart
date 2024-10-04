import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final String hintText;
  final int maxLines;
  final TextEditingController controller;

  const CustomTextArea({
    Key? key,
    required this.hintText,
    required this.controller,
    this.maxLines = 5, // Puedes definir la cantidad de líneas por defecto
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.blue, // Color al enfocarse
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
      ),
    );
  }
}
