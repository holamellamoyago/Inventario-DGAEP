import 'package:firebase_web/presentation/screens_widgets.dart';

class PreferenciasInventario {
  static late SharedPreferences prefs;

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  String get ultimoEscaneo {
    return prefs.getString('ultimoEscaneo') ?? '999';
  }

  set ultimoEscaneo(String value) {
    prefs.setString('ultimoEscaneo', value);
  }

  String get ultimoPerifericoSeleccionado {
    return prefs.getString('ultimoPerifericoSeleccionado') ?? 'Seleccione un periferico';
  }

  set ultimoPerifericoSeleccionado(String value) {
    prefs.setString('ultimoPerifericoSeleccionado', value);
  }
  String get ultimaFotoSacada {
    return prefs.getString('ultimaFotoSacada') ?? 'a';
  }

  set ultimaFotoSacada(String value) {
    prefs.setString('ultimaFotoSacada', value);
  }
  String get prueba {
    return prefs.getString('prueba') ?? 'a';
  }

  set prueba(String value) {
    prefs.setString('prueba', value);
  }
}
