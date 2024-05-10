import 'package:firebase_web/configure/preferences/prefs_inventario.dart';
import 'package:flutter/material.dart';

class DetallesOrdenador extends StatefulWidget {
  static const name = '/detallesOrdenador_screen';
  const DetallesOrdenador({super.key});

  @override
  State<DetallesOrdenador> createState() => _DetallesOrdenadorState();
}

class _DetallesOrdenadorState extends State<DetallesOrdenador> {
  var prefs = PreferenciasInventario();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de ordenadores'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(prefs.ultimoEscaneo),
      ),
    );
  }
}
