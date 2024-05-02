import 'package:firebase_web/presentation/screens_widgets.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class CreacionOrdenadores extends StatefulWidget {
  static const name = 'creacion_ordenadores_screen';
  const CreacionOrdenadores({super.key});

  @override
  State<CreacionOrdenadores> createState() => _CreacionOrdenadoresState();
}

class _CreacionOrdenadoresState extends State<CreacionOrdenadores> {
  TextEditingController nombreEquipoController = TextEditingController();
  TextEditingController numeroSerieController = TextEditingController();
  TextEditingController especificacionesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final titleStyleLarge = Theme.of(context).textTheme.titleLarge;
    var size = MediaQuery.of(context).size;

    String nombreEquipoLabel = 'Introduce el nombre de equipo';
    String numeroSerieLabel = 'Introduce el numero de serie de equipo';
    String especificacionesLabel = 'Introduce las especificaciones del equipo';

    String tituloAppBar = 'Creación do ordenador';

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarCustom(
              tituloAppBar: tituloAppBar,
              titleStyleLarge: titleStyleLarge,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre de equipo',
                      style: titleStyleLarge,
                    ),
                    PaddingCustom(
                      height: 8,
                    ),
                    TextFieldcustom(
                        nombreEquipoLabel: nombreEquipoLabel,
                        nombreEquipoController: nombreEquipoController),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Numero de serie',
                      style: titleStyleLarge,
                    ),
                    SizedBox(height: 8),
                    TextFieldcustom(
                        nombreEquipoLabel: numeroSerieLabel,
                        nombreEquipoController: numeroSerieController),
                    SizedBox(height: 24),
                    Text(
                      'Especificaciones del equipo',
                      style: titleStyleLarge,
                    ),
                    SizedBox(height: 8),
                    TextFieldcustom(
                        nombreEquipoLabel: especificacionesLabel,
                        nombreEquipoController: especificacionesController),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                            onPressed: uploadPC, child: Text('Añadir nuevo PC'))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void uploadPC() async {
    String nameComputer = nombreEquipoController.text;
    String numberSerie = numeroSerieController.text;
    String especificaciones = especificacionesController.text;
    String id = randomAlphaNumeric(20);

    print('LLego a la función');

    await FirebaseFirestore.instance
        .collection('dgaep')
        .doc('inventario')
        .collection('ordenadores')
        .doc(id.toString())
        .set({
      'nombre_equipo': nameComputer,
      'numero_serie': numberSerie,
      'especificaciones': especificaciones
    });
    context.pop();
  }
}

class PaddingCustom extends StatelessWidget {
  double height;
  double width;
  PaddingCustom({
    super.key,
    this.height = 0,
    this.width = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}

class TextFieldcustom extends StatelessWidget {
  const TextFieldcustom({
    super.key,
    required this.nombreEquipoLabel,
    required this.nombreEquipoController,
  });

  final String nombreEquipoLabel;
  final TextEditingController nombreEquipoController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(), label: Text(nombreEquipoLabel)),
      controller: nombreEquipoController,
    );
  }
}
