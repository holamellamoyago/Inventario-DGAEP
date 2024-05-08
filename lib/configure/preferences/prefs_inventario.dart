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
  String get ultimaFotoSacada {
    return prefs.getString('ultimaFotoSacada') ?? 'https://storage.googleapis.com/cms-storage-bucket/a9d6ce81aee44ae017ee.png';
  }

  set ultimaFotoSacada(String value) {
    prefs.setString('ultimaFotoSacada', value);
  }
}
