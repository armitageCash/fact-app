import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final Widget child;

  const Screen({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var isLargeScreen = screenWidth > 600;
    return Center(
      child: SizedBox(
        width: isLargeScreen ? 375.0 : double.infinity,
        child: child,
      ),
    );
  }
}
