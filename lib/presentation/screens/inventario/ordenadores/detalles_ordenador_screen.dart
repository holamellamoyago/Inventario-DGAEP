import 'package:firebase_web/presentation/Models/inventarioModel.dart';
import 'package:firebase_web/presentation/screens_widgets.dart';
import 'package:flutter/material.dart';

class DetallesOrdenador extends StatefulWidget {
  static const name = '/detallesOrdenador_screen';
  const DetallesOrdenador({super.key});

  @override
  State<DetallesOrdenador> createState() => _DetallesOrdenadorState();
}

class _DetallesOrdenadorState extends State<DetallesOrdenador> {
  @override
  void initState() {
    controllers();
    super.initState();
  }

  TextEditingController donoController = TextEditingController();
  TextEditingController memoriaRamController = TextEditingController();
  TextEditingController perifericoController = TextEditingController();
  TextEditingController serialNumberController = TextEditingController();
  TextEditingController procesadorController = TextEditingController();

  var prefsO = PreferenciasOrdenadores();

  @override
  Widget build(BuildContext context) {
    var future = FirebaseFirestore.instance
        .collection('dgaep')
        .doc('inventario')
        .collection(prefs.ultimoPerifericoSeleccionado)
        .doc(prefs.ultimoEscaneo);

    var size = MediaQuery.of(context).size;

    final titleStyleLarge = Theme.of(context).textTheme.titleLarge;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalles de ordenadores'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
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

                donoController.text = prefsO.dono;

                return snapshot.hasData
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dono do ordenador:',
                            style: titleStyleLarge,
                          ),
                          const PaddingCustom(
                            height: 10,
                          ),
                          TextField(
                            controller: donoController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                          Text('Serial number'),
                          TextField(
                            controller: serialNumberController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                          const PaddingCustom(
                            height: 10,
                          ),
                          Text(
                            '¿Esta o ordenador disponible?',
                            style: titleStyleLarge,
                          ),
                          const PaddingCustom(
                            width: 10,
                          ),
                          Switch(
                            value: disponible,
                            onChanged: (value) {
                              var disponible = value;
                              disponible != value;
                              future.update({'Disponible': disponible});
                              setState(() {});
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FilledButton(
                                  onPressed: () async {
                                    await future.update({
                                      'Dono': donoController.text,
                                    });
                                  },
                                  child: const Text('Actualizar ordenador')),
                            ],
                          )
                        ],
                      )
                    : const CircularProgressIndicator();
              },
            ),
          ),
        ));
  }

  void controllers() async {
    final ref = FirebaseFirestore.instance
        .collection('dgaep')
        .doc('inventario')
        .collection('Ordenador')
        .doc('9728401485004')
        .withConverter(
          fromFirestore: Inventario.fromFirestore,
          toFirestore: (Inventario inventario, _) => inventario.toFirestore(),
        );
    final docSnap = await ref.get();
    final inventario = docSnap.data();
    if (inventario != null) {
      prefsO.dono = inventario.dono!;
      showSnackBar(context, prefsO.dono);
    }
  }
}
