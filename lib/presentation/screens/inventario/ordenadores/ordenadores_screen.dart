import 'package:firebase_web/presentation/screens_widgets.dart';
import 'package:flutter/material.dart';

class OrdenadoresScreen extends StatefulWidget {
  static const name = 'ordenadores_screen';
  const OrdenadoresScreen({super.key});

  @override
  State<OrdenadoresScreen> createState() => _OrdenadoresScreenState();
}

class _OrdenadoresScreenState extends State<OrdenadoresScreen> {
  var prefs = PreferenciasInventario();
  var prefsO = PreferenciasOrdenadores();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream? ordenadoresStream;
  Stream? ordenadoresDisponiblesStream;
  Query? ordenadoresDisponibles;
  int contadorOrdenadoresDisponibles = 0;

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final titleStyleLarge = Theme.of(context).textTheme.titleLarge;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de ordenadores'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: ordenadoresStream,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CardContainer(
                              size: size,
                              string:
                                  'Total \nde \nordenadores:\n ${snapshot.data.docs.length}',
                            ),
                            contadorOrdenadoresDisponibles >= 0
                                ? FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('dgaep')
                                        .doc('inventario')
                                        .collection("Ordenador")
                                        .where('Disponible', isEqualTo: true)
                                        .get(),
                                    builder: (context, snapshot) {
                                      return CardContainer(
                                          size: size,
                                          string:
                                              'Ordenadores \n disponibles:\n ${snapshot.data?.docs.length}');
                                    },
                                  )
                                : const CircularProgressIndicator(),
                          ],
                        )
                      : const Center(
                          child: Column(
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ));
                },
              ),
              StreamBuilder(
                stream: ordenadoresStream,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Expanded(
                          child: ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot ordenadoresSnapshot =
                                snapshot.data.docs[index];
                            String dono = ordenadoresSnapshot['Dono'];
                            String serialNumber =
                                ordenadoresSnapshot['Serial_number'];
                            String periferico =
                                ordenadoresSnapshot['Periferico'];
                            return ListTile(
                              title: Text(dono),
                              subtitle: Text(serialNumber),
                              leading: Icon(
                                Icons.add_circle_sharp,
                                color: ordenadoresSnapshot['Disponible'] == true
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              trailing: const Icon(Icons.arrow_right_outlined),
                              onTap: () async {
                                prefs.ultimoEscaneo = serialNumber;
                                prefs.ultimoPerifericoSeleccionado = periferico;
                                context.push('/detallesOrdenador_screen');
                              },
                            );
                          },
                        ))
                      : const Column(
                          children: [CircularProgressIndicator()],
                        );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          context.push('/creacion_ordenadores_screen');
        },
        child: const Icon(Icons.computer),
      ),
    );
  }

  getOnTheLoad() async {
    ordenadoresStream = await DataBaseMethods().getOrdenadoresDetails();
    setState(() {});
  }
}
