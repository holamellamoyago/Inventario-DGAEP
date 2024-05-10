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
        child: Column(
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
                                            'Ordenadores \n disponibles:\n ${snapshot.data!.docs.length}');
                                  },
                                )
                              : const CircularProgressIndicator(),
                        ],
                      )
                    : const CircularProgressIndicator();
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
                          String title = ordenadoresSnapshot['Serial_number'];
                          String subtitle = ordenadoresSnapshot['Periferico'];
                          return ListTile(
                            title: Text(title),
                            subtitle: Text(subtitle),
                            trailing: const Icon(Icons.arrow_right_outlined),
                            onTap: () async {
                              prefs.ultimoEscaneo = title;
                              prefs.ultimoPerifericoSeleccionado = subtitle;
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
