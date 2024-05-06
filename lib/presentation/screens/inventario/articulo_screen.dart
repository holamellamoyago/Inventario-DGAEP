import 'package:firebase_web/configure/preferences/prefs_inventario.dart';
import 'package:firebase_web/presentation/screens_widgets.dart';
import 'package:flutter/material.dart';

class ArticuloScreen extends StatefulWidget {
  static const name = '/articulo_screen';
  const ArticuloScreen({super.key});

  @override
  State<ArticuloScreen> createState() => _ArticuloScreenState();
}

class _ArticuloScreenState extends State<ArticuloScreen> {
  var prefs = PreferenciasInventario();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    TextEditingController serialNumberController =
        TextEditingController(text: prefs.ultimoEscaneo);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Articulo: ${prefs.ultimoEscaneo}',
        ),
        centerTitle: true,
      ),
      body: Placeholder(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: serialNumberController,
            readOnly: false,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: Text(prefs.ultimoEscaneo),
              icon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.camera),
              ),
            ),
          ),
          const Center(
            child: Text('Prueba'),
          ),
          OutlinedButton(onPressed: crearNuevoArticulo, child: const Text('Test')),
        ],
      )),
    );
  }

  void crearNuevoArticulo() async {
    final db = FirebaseFirestore.instance;

    final datos = <String, dynamic>{
      'Serial_number': 1234.toString(),
      'Model': 'Hub'
    };

    await db
        .collection('dgaep-inventario')
        .doc(prefs.ultimoEscaneo)
        .set({'Serial_number': '1234'});
  }
}
