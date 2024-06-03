import 'package:flutter/material.dart';

class ClickableCard extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const ClickableCard(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: child,
      ),
    );
  }
}
