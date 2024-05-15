
import 'package:firebase_web/presentation/screens_widgets.dart';
import 'package:flutter/material.dart';

class MenuContainer extends StatelessWidget {
  const MenuContainer({super.key, required this.size, required this.icono});

  final Size size;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.4,
      height: size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.cyan[400],
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Center(
        child: Icon(icono),
      ),
    );
  }
}

class CardContainer extends StatelessWidget {
  const CardContainer({super.key, required this.size, required this.string});

  final Size size;
  final String string;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.20,
      width: size.width * 0.40,
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: const Color.fromARGB(255, 39, 93, 41), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Center(
          child: Text(
            string,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({
    super.key,
    required this.tituloAppBar,
    required this.titleStyleLarge,
  });

  final String tituloAppBar;
  final TextStyle? titleStyleLarge;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
        Text(
          tituloAppBar,
          style: titleStyleLarge,
        ),
        const SizedBox(
          width: 24,
        )
      ],
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}


class PaddingCustom extends StatelessWidget {
  final double height;
  final double width;
  const PaddingCustom({
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
    required this.texto,
    required this.controller,
  });

  final String texto;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(), label: Text(texto)),
      controller: controller,
    );
  }
} 


class DropDownButtonCustom extends StatefulWidget {
  DropDownButtonCustom(
      {super.key, required this.opcionSeleccionada, required this.lista});
  String opcionSeleccionada;
  final List<String> lista;

  @override
  State<DropDownButtonCustom> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButton<String>(
        
        underline: Container(height: 2,color: Colors.blueAccent,),
        value: widget.opcionSeleccionada,
        icon: const Icon(Icons.arrow_downward),
        isExpanded: true,
        items: widget.lista.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
            
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            widget.opcionSeleccionada = value!;
            showSnackBar(context, widget.opcionSeleccionada);
          });
        },
      ),
    );
  }
}
