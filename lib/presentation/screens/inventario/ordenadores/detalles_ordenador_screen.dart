import 'package:flutter/material.dart';

class DetallesOrdenador extends StatefulWidget {
  static const name = '/detallesOrdenador_screen';
  const DetallesOrdenador({super.key});

  @override
  State<DetallesOrdenador> createState() => _DetallesOrdenadorState();
}

class _DetallesOrdenadorState extends State<DetallesOrdenador> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de ordenadores'),
        centerTitle: true,
      ),
    );
  }
}
