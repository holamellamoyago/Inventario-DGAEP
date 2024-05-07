import 'package:firebase_web/presentation/screens_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArticuloScreen extends StatefulWidget {
  static const name = '/articulo_screen';
  const ArticuloScreen({super.key});

  @override
  State<ArticuloScreen> createState() => _ArticuloScreenState();
}

List<String> perifericos = <String>[
  'Seleccione tipo de periferico',
  'Ordenador',
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
            TextField(
              controller: personaController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('¿ Para que persoa vai?')),
            ),
            const PaddingCustom(
              height: 20,
            ),
            TextField(
              controller: serialNumberController,
              readOnly: false,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: scannerQR,
                  icon: const Icon(Icons.camera_alt_outlined),
                ),
                label: Text(prefs.ultimoEscaneo),
              ),
            ),
            const PaddingCustom(
              height: 10,
            ),
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
            opcionSeleccionadaPerifericos == 'Ordenador'
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
            const PaddingCustom(
              height: 10,
            ),
            OutlinedButton(
                onPressed: () {
                  crearNuevoArticulo();
                  context.go('/');
                },
                child: const Text('Enviar ao inventario')),
          ],
        ),
      ),
    );
  }

  void crearNuevoArticulo() async {
    final db = FirebaseFirestore.instance;

    final persona =
        personaController.text.isEmpty ? 'Nadie' : personaController.text;

    await db
        .collection('dgaep')
        .doc('inventario')
        .collection(opcionSeleccionadaPerifericos)
        .doc(prefs.ultimoEscaneo)
        .set({
      'Serial_number': prefs.ultimoEscaneo,
      'Periferico': opcionSeleccionadaPerifericos,
      'Dono': persona,
      'Disponible': true
    });
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
