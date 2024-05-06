import 'dart:html';

import 'package:firebase_web/presentation/screens_widgets.dart';
import 'package:flutter/material.dart';

class MenuContainer extends StatelessWidget {
  const MenuContainer({super.key, required this.size, required this.icono});

  final Size size;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.4,
      height: size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.cyan[400],
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Center(
        child: Icon(icono),
      ),
    );
  }
}

class CardContainer extends StatelessWidget {
  const CardContainer({super.key, required this.size, required this.string});

  final Size size;
  final String string;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.20,
      width: size.width * 0.40,
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: const Color.fromARGB(255, 39, 93, 41), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Center(
          child: Text(
            string,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({
    super.key,
    required this.tituloAppBar,
    required this.titleStyleLarge,
  });

  final String tituloAppBar;
  final TextStyle? titleStyleLarge;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
        Text(
          tituloAppBar,
          style: titleStyleLarge,
        ),
        const SizedBox(
          width: 24,
        )
      ],
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), dismissDirection: DismissDirection.horizontal, duration: const Duration(seconds: 3),)
  );
}
