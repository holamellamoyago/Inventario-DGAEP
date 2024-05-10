import 'package:firebase_web/configure/preferences/prefs_inventario.dart';
import 'package:firebase_web/presentation/screens_widgets.dart';
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
    TextEditingController donoController = TextEditingController();
    TextEditingController memoriaRamController = TextEditingController();
    TextEditingController perifericoController = TextEditingController();
    TextEditingController serialNumberController = TextEditingController();
    TextEditingController procesadorController = TextEditingController();

    final titleStyleLarge = Theme.of(context).textTheme.titleLarge;

    var future = FirebaseFirestore.instance
        .collection('dgaep')
        .doc('inventario')
        .collection(prefs.ultimoPerifericoSeleccionado)
        .doc(prefs.ultimoEscaneo);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de ordenadores'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: future.get(),
          builder: (context, snapshot) {
            final _data = snapshot.data;
            final dono = _data?['Dono'];
            final memoria_RAM = _data?['Memoria_RAM'];
            final disponible = _data?['Disponible'];
            final periferico = _data?['Periferico'];
            final procesador = _data?['Procesador'];
            final serial_number = _data?['Serial_number'];
            return snapshot.hasData
                ? Column(
                    children: [
                      Text('Dono do ordenador:', style: titleStyleLarge,),
                      TextFieldcustom(texto: dono, controller: donoController),
                      Text('¿Esta o ordenador disponible?', style: titleStyleLarge,),
                      Switch(
                        value: disponible,
                        onChanged: (value) {
                          var disponible = value;
                          disponible != value;
                          future.update({
                            'Disponible': disponible
                          }
                          );
                          setState(() {});
                        },
                      ),
                    ],
                  )
                : const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
