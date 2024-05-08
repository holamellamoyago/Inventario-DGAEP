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
    return prefs.getString('ultimoPerifericoSeleccionado') ?? '';
  }

  set ultimoPerifericoSeleccionado(String value) {
    prefs.setString('ultimoPerifericoSeleccionado', value);
  }
}
