import 'package:firebase_web/presentation/Models/inventario_model.dart';
import 'package:firebase_web/presentation/screens_widgets.dart';
import 'package:flutter/material.dart';

class DetallesOrdenador extends StatefulWidget {
  static const name = '/detallesOrdenador_screen';
  const DetallesOrdenador({super.key});

  @override
  State<DetallesOrdenador> createState() => _DetallesOrdenadorState();
}

class _DetallesOrdenadorState extends State<DetallesOrdenador> {
  var prefsO = PreferenciasOrdenadores();

  TextEditingController donoController = TextEditingController();
  TextEditingController memoriaRamController = TextEditingController();
  TextEditingController perifericoController = TextEditingController();
  TextEditingController serialNumberController = TextEditingController();
  TextEditingController procesadorController = TextEditingController();

  String opcionSeleccionadaPerifericos = perifericos.first;
  String opcionSeleccionadaProcesador = ordenadoresProcesador.first;
  String opcionSeleccionadaRAM = ordenadoresRAM.first;
  String opcionSeleccionadaResolucion = monitoresResolucion.first;
  String opcionSeleccionadaPulgadas = monitoresPulgadas.first;

  @override
  void initState() {
    controllers();
    super.initState();
  }

  var future = FirebaseFirestore.instance
      .collection('dgaep')
      .doc('inventario')
      .collection(prefs.ultimoPerifericoSeleccionado)
      .doc(prefs.ultimoEscaneo);

  @override
  Widget build(BuildContext context) {
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
              final data = snapshot.data;
              final disponible = data?['Disponible'];
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
                        Text(
                          'Serial number',
                          style: titleStyleLarge,
                        ),
                        TextField(
                          controller: serialNumberController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                        const PaddingCustom(
                          height: 10,
                        ),
                        DropdownMenu(
                          controller: perifericoController,
                          expandedInsets: EdgeInsets.zero,
                          // expandedInsets: EdgeInsets.zero,
                          label: Text(prefs.ultimoPerifericoSeleccionado),
                          dropdownMenuEntries: perifericos
                              .map<DropdownMenuEntry<String>>((String value2) {
                            return DropdownMenuEntry(
                              value: value2,
                              label: value2,
                            );
                          }).toList(),
                          onSelected: (value2) async {
                            setState(() {
                              perifericoController.text = value2!;
                              prefsO.periferico = value2;
                              showSnackBar(
                                  context, prefsO.periferico);
                            });
                          },
                        ),
                        prefsO.periferico == 'Portatil' || prefsO.periferico == 'Ordenador' ? especificacionesOrdenador() : prefsO.periferico == 'Monitor' ? especificacionesMonitor() : const SizedBox(),
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
      ),
    );
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
      prefsO.memoriaRAM = inventario.memoriaRAM!;
      prefsO.periferico = inventario.periferico!;
      prefsO.procesador = inventario.procesador!;
      prefsO.serialNumber = inventario.serialNumber!;
      prefsO.imageURL = inventario.imageURL!;
      prefsO.disponible = inventario.disponible!;

      donoController.text = prefsO.dono;
      memoriaRamController.text = prefsO.memoriaRAM;
      perifericoController.text = prefsO.periferico;
      procesadorController.text = prefsO.procesador;
      serialNumberController.text = prefsO.serialNumber;

      showSnackBar(context, prefsO.dono);
    }
  }

  Widget especificacionesMonitor() {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DropDownButtonCustom(
            opcionSeleccionada: opcionSeleccionadaResolucion,
            lista: monitoresResolucion),
        PaddingCustom(
          width: size.width * 0.1,
        ),
        DropDownButtonCustom(
            opcionSeleccionada: opcionSeleccionadaPulgadas,
            lista: monitoresPulgadas)
      ],
    );
  }

    Widget especificacionesOrdenador() {
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            value: opcionSeleccionadaProcesador,
            isExpanded: true,
            icon: const Icon(Icons.arrow_downward),
            // elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                opcionSeleccionadaProcesador = value!;
              });
              showSnackBar(context, opcionSeleccionadaProcesador);
            },
            items: ordenadoresProcesador
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        const SizedBox(
          width: 40,
        ),
        Expanded(
          child: DropdownButton<String>(
            value: opcionSeleccionadaRAM,
            isExpanded: true,
            icon: const Icon(Icons.arrow_downward),
            // elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                opcionSeleccionadaRAM = value!;
              });
              showSnackBar(context, opcionSeleccionadaRAM);
            },
            items: ordenadoresRAM.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
