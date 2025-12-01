import 'package:flutter/material.dart';

class CardEstado extends StatelessWidget {
  final Color background;
  final List<Widget> children;
  const CardEstado({
    required this.background,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: background,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}