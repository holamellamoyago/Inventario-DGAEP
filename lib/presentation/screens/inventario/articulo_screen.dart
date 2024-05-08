import 'dart:io';

import 'package:firebase_web/configure/Storage/image_picker.dart';
import 'package:firebase_web/configure/Storage/storage.dart';
import 'package:firebase_web/presentation/screens_widgets.dart';
import 'package:flutter/material.dart';

class ArticuloScreen extends StatefulWidget {
  static const name = '/articulo_screen';
  const ArticuloScreen({super.key});

  @override
  State<ArticuloScreen> createState() => _ArticuloScreenState();
}

List<String> perifericos = <String>[
  'Seleccione tipo de periferico',
  'Ordenador',
  'Portatil',
  'Monitores',
  'Ratones',
  'Hub Dell'
];

List<String> ordenadoresProcesador = <String>[
  'Pentium',
  'Ryzen',
  'Intel I3',
  'Intel I5',
  'Intel I7',
  'Intel I9'
];

List<String> ordenadoresRAM = <String>[
  '4 GB',
  '8 GB',
  '12 GB',
  '16 GB',
  '32 GB',
  '64 GB',
];

class _ArticuloScreenState extends State<ArticuloScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var prefs = PreferenciasInventario();

  // Scaner
  String codigoBarras = '';
  // String dropDownMenuValue ;
  String opcionSeleccionadaPerifericos = perifericos.first;
  String opcionSeleccionadaProcesador = ordenadoresProcesador.first;
  String opcionSeleccionadaRAM = ordenadoresRAM.first;

  TextEditingController personaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final titleStyleLarge = Theme.of(context).textTheme.titleLarge;
    TextEditingController serialNumberController =
        TextEditingController(text: prefs.ultimoEscaneo);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Articulo: ${prefs.ultimoEscaneo}',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Datos do formulario',
              style: titleStyleLarge,
            ),
            const PaddingCustom(
              height: 10,
            ),
            textFieldNombrePersona(context),
            const PaddingCustom(
              height: 20,
            ),
            textFieldSerialNumber(context, serialNumberController),
            const PaddingCustom(
              height: 10,
            ),
            dropDownMenuOrdenadores(context),
            const PaddingCustom(
              height: 10,
            ),
            const PaddingCustom(
              height: 10,
            ),
            containerImagen(context),
            OutlinedButton(
                onPressed: () {
                  crearNuevoArticulo();
                  context.go('/');
                },
                child: const Text('Enviar ao inventario')),
            OutlinedButton(
                onPressed: () {
                  showSnackBar(context, serialNumberController.text);
                },
                child: Text('Mostrar el p'))
          ],
        ),
      ),
    );
  }

  Widget dropDownMenuOrdenadores(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: opcionSeleccionadaPerifericos,
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
              opcionSeleccionadaPerifericos = value!;
              prefs.ultimoPerifericoSeleccionado = value;
            });
            showSnackBar(context, opcionSeleccionadaPerifericos);
          },
          items: perifericos.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        opcionSeleccionadaPerifericos == 'Ordenador' ||
                opcionSeleccionadaPerifericos == 'Portatil'
            ? Row(
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
                      items: ordenadoresRAM
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }

  Widget textFieldSerialNumber(BuildContext context, serialNumberController) {
    return TextField(
      controller: serialNumberController,
      readOnly: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: scannerQR, //scannerQr,
          icon: const Icon(Icons.qr_code_2_sharp),
        ),
        label: const Text('Serial number'),
      ),
    );
  }

  Widget textFieldNombrePersona(BuildContext context) {
    return TextField(
      controller: personaController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text('¿ Para que persoa vai?')),
    );
  }

  Widget containerImagen(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ImageNetwork(
                    image:
                        'https://storage.googleapis.com/cms-storage-bucket/a9d6ce81aee44ae017ee.png',
                    height: 200,
                    width: 200),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Upload your image'),
                  IconButton(
                      onPressed: () async {
                        final image = await getImage();
                        if (image == null) {
                          return;
                        } else {
                          final imageUploaded = File(image.path);
                          final uploaded = await uploadImageProfile(
                              imageUploaded, prefs.ultimoEscaneo);
                          uploaded
                              ? showSnackBar(
                                  context, 'Imagen subida correctamente')
                              : showSnackBar(context, 'Imagen erronea');
                        }
                      },
                      icon: Icon(Icons.camera_alt_outlined))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void crearNuevoArticulo() async {
    final db = FirebaseFirestore.instance;

    final persona =
        personaController.text.isEmpty ? 'Nadie' : personaController.text;
    final periferico = opcionSeleccionadaPerifericos;
    final procesador = opcionSeleccionadaProcesador;
    final ram = opcionSeleccionadaRAM;

    if (opcionSeleccionadaPerifericos == 'Ordenador' ||
        opcionSeleccionadaPerifericos == 'Portatil') {
      await db
          .collection('dgaep')
          .doc('inventario')
          .collection(periferico)
          .doc(prefs.ultimoEscaneo)
          .set({
        'Serial_number': prefs.ultimoEscaneo,
        'Periferico': opcionSeleccionadaPerifericos,
        'Dono': persona,
        'Disponible': false,
        'Procesador': procesador,
        'Memoria_RAM': ram
      });
    } else {
      await db
          .collection('dgaep')
          .doc('inventario')
          .collection(opcionSeleccionadaPerifericos)
          .doc(prefs.ultimoEscaneo)
          .update({
        'Serial_number': prefs.ultimoEscaneo,
        'Periferico': opcionSeleccionadaPerifericos,
        'Dono': persona,
        'Disponible': true
      });
    }
  }

  Future<void> scannerQR() async {
    var prefs = PreferenciasInventario();
    String barcodeScanRes;
    var status = await Permission.camera.request();

    status.isDenied
        ? showSnackBar(context, 'Permiso denegado')
        : showSnackBar(context, 'Permiso concedido');

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", 'Cancelar', true, ScanMode.QR);
      prefs.ultimoEscaneo = barcodeScanRes;
    } catch (e) {
      showSnackBar(context, 'Ocurrio un mensaje en la lectura del código QR');
      barcodeScanRes = 'ff';
      return;
    }

    setState(() {
      codigoBarras = barcodeScanRes;
    });

    prefs.ultimoEscaneo = barcodeScanRes;

    prefs.ultimoEscaneo != null
        ? context.push('/articulo_screen')
        : showSnackBar(context, 'Hubo un error');
  }
}
