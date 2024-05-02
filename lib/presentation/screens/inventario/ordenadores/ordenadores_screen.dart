
import 'package:firebase_web/presentation/screens_widgets.dart';
import 'package:flutter/material.dart';

class OrdenadoresScreen extends StatefulWidget {
  static const name = 'ordenadores_screen';
  const OrdenadoresScreen({super.key});

  @override
  State<OrdenadoresScreen> createState() => _OrdenadoresScreenState();
}

class _OrdenadoresScreenState extends State<OrdenadoresScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream? ordenadoresStream;
  Query? ordenadoresDisponibles;
  int contadorOrdenadoresDisponibles = 0;

  getOrdenadoresDisponibles() async {
    var numero = await FirebaseFirestore.instance
        .collection('dgaep')
        .doc('inventario')
        .collection("ordenadores")
        .where('Disponible', isEqualTo: true)
        .get();
    setState(() {
      contadorOrdenadoresDisponibles = numero.size;
    });
  }

  getOnTheLoad() async {
    ordenadoresStream = await DataBaseMethods().getOrdenadoresDetails();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    getOrdenadoresDisponibles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final titleStyleLarge = Theme.of(context).textTheme.titleLarge;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarCustom(
                tituloAppBar: 'Listado dos ordenadores',
                titleStyleLarge: titleStyleLarge,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StreamBuilder(
                  stream: ordenadoresStream,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? CardContainer(
                            size: size,
                            string:
                                'Total \nde \nordenadores:\n ${snapshot.data.docs.length}',
                          )
                        : const CircularProgressIndicator();
                  },
                ),
                contadorOrdenadoresDisponibles >= 1
                    ? CardContainer(
                        size: size,
                        string:
                            'Ordenadores disponibles:\n ${contadorOrdenadoresDisponibles.toString()}',
                      )
                    : const CircularProgressIndicator(),
              ],
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
                          return ListTile(
                            title: Text(ordenadoresSnapshot['nombre_equipo']),
                            subtitle: Text(ordenadoresSnapshot['numero_serie']),
                          );
                        },
                      ))
                    : const Column(
                        children: [CircularProgressIndicator()],
                      );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/creacion_ordenadores_screen'),
        child: const Icon(Icons.computer),
      ),
    );
  }
}


