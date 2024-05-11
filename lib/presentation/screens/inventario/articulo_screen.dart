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
  'Ordenador',
  'Portatil',
  'Monitor',
  'Raton',
  'Teclado',
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

List<String> monitoresResolucion = <String>[
  '1440 x 900',
  '1920 x 1080',
  '2560 x 1440',
  '3840 x 2160'
];

List<String> monitoresPulgadas = <String>[
  '19"',
  '21"',
  '24"',
  '27"',
  '32"',
  '36"',
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
  String opcionSeleccionadaResolucion = monitoresResolucion.first;
  String opcionSeleccionadaPulgadas = monitoresPulgadas.first;

  TextEditingController personaController = TextEditingController();

  @override
  void initState() {
    // crearNuevoArticulo();
    super.initState();
  }

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
      body: SingleChildScrollView(
        child: Padding(
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
              // dropDownMenuOrdenadores(context),
              dropDownMenuCustom(),
              prefs.ultimoPerifericoSeleccionado == 'Ordenador' ||
                      prefs.ultimoPerifericoSeleccionado == 'Portatil'
                  ? especificacionesOrdenador()
                  : prefs.ultimoPerifericoSeleccionado == 'Monitor'
                      ? especificacionesMonitor()
                      : SizedBox(),
              const PaddingCustom(
                height: 10,
              ),
              const PaddingCustom(
                height: 10,
              ),
              containerImagen(context),
              OutlinedButton(
                  onPressed: () async {
                    crearNuevoArticulo();
                    context.go('/');
                    prefs.ultimoPerifericoSeleccionado =
                        'Seleccione un periferico';
                  },
                  child: const Text('Enviar ao inventario')),
              OutlinedButton(
                  onPressed: () {
                    showSnackBar(context, prefs.ultimaFotoSacada);
                    prefs.ultimaFotoSacada =
                        'https://storage.googleapis.com/cms-storage-bucket/a9d6ce81aee44ae017ee.png';
                  },
                  child: const Text('Mostrar el p')),
              OutlinedButton(
                  onPressed: () async {
                    prefs.ultimoPerifericoSeleccionado = 'Hub';
                    showSnackBar(context, prefs.ultimoPerifericoSeleccionado);
                  },
                  child: const Text('Reiniciar a portatil')),
            ],
          ),
        ),
      ),
    );
  }

  Widget especificacionesMonitor() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DropDownMenu3(
            opcionSeleccionada: opcionSeleccionadaResolucion,
            lista: monitoresResolucion),
        DropDownMenu3(
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

  Widget dropDownMenuCustom() {
    TextEditingController perifericoController = TextEditingController();
    return DropdownMenu(
      controller: perifericoController,
      expandedInsets: EdgeInsets.zero,
      // expandedInsets: EdgeInsets.zero,
      label: Text(prefs.ultimoPerifericoSeleccionado),
      dropdownMenuEntries:
          perifericos.map<DropdownMenuEntry<String>>((String value2) {
        return DropdownMenuEntry(
          value: value2,
          label: value2,
        );
      }).toList(),
      onSelected: (value2) async {
        setState(() {
          perifericoController.text = value2!;
          prefs.ultimoPerifericoSeleccionado = value2;
          showSnackBar(context, prefs.ultimoPerifericoSeleccionado);
        });
      },
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

  void crearNuevoArticulo() async {
    final db = FirebaseFirestore.instance;

    final persona =
        personaController.text.isEmpty ? 'Nadie' : personaController.text;
    final periferico = opcionSeleccionadaPerifericos;
    final procesador = opcionSeleccionadaProcesador;
    final ram = opcionSeleccionadaRAM;
    final image = prefs.ultimaFotoSacada;

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
        'Memoria_RAM': ram,
        'image_url': image
      });
      prefs.ultimaFotoSacada =
          'https://storage.googleapis.com/cms-storage-bucket/a9d6ce81aee44ae017ee.png';
    } else {
      await db
          .collection('dgaep')
          .doc('inventario')
          .collection(opcionSeleccionadaPerifericos)
          .doc(prefs.ultimoEscaneo)
          .set({
        'Serial_number': prefs.ultimoEscaneo,
        'Periferico': opcionSeleccionadaPerifericos,
        'Dono': persona,
        'Disponible': true,
        'image_url': image
      });
      prefs.ultimaFotoSacada =
          'https://storage.googleapis.com/cms-storage-bucket/a9d6ce81aee44ae017ee.png';
    }
  }

  Future<void> getImageRef() async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final PreferenciasInventario prefs = PreferenciasInventario();
    final image = await getImage();

    if (image == null) {
      return;
    } else {
      final imageUploaded = File(image.path);
      final uploaded =
          await uploadImageProfile(imageUploaded, prefs.ultimoEscaneo);
      if (uploaded) {
        showSnackBar(context, 'Imagen subida');
      } else {
        showSnackBar(context, 'Error imagen');
      }

      final Reference ref = storage
          .ref()
          .child('dgaep')
          .child('inventario')
          .child(prefs.ultimoEscaneo);

      prefs.ultimaFotoSacada = await ref.getDownloadURL();

      showSnackBar(context, 'Funcion lograda');
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
                    image: prefs.ultimaFotoSacada, height: 200, width: 300)
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
                  const Text('Upload your image'),
                  IconButton(
                      onPressed: () async {
                        await getImageRef();
                        setState(() {
                          prefs.ultimaFotoSacada;
                        });
                        // pasarScreen();
                      },
                      icon: const Icon(Icons.camera_alt_outlined))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void pasarScreen() async {
    showSnackBar(context, 'Snackbar antes de moverse');
    context.push('/articulo_screen');
  }
}

// class DropDownButtonCustom2 extends StatefulWidget {

//   DropDownButtonCustom2({
//     super.key,
//     required this.opcionSeleccionada,
//     required this.lista
//   });

//   @override
//   State<DropDownButtonCustom2> createState() => _DropDownButtonCustom2State(lista: lista, opcionSeleccionada: opcionSeleccionada);
// }

// class _DropDownButtonCustom2State extends State<DropDownButtonCustom2> {
//   String opcionSeleccionadaResolucion = monitoresResolucion.first;
//     final String lista;
//   final String opcionSeleccionada;

//   _DropDownButtonCustom2State({required this.lista, required this.opcionSeleccionada});
//   @override
//   Widget build(BuildContext context) {
//     return
//   }

// }

class DropDownMenu3 extends StatefulWidget {
  DropDownMenu3(
      {super.key, required this.opcionSeleccionada, required this.lista});
  String opcionSeleccionada;
  final List<String> lista;

  @override
  State<DropDownMenu3> createState() => _DropDownMenu3State();
}

class _DropDownMenu3State extends State<DropDownMenu3> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.opcionSeleccionada,
      items: widget.lista.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          child: Text(value),
          value: value,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          widget.opcionSeleccionada = value!;
          showSnackBar(context, widget.opcionSeleccionada);
        });
      },
    );
  }
}

// Tengo que hacer que con el boton de abajo limpiar las prefs y así comprobar de verdad quien es el prf.
