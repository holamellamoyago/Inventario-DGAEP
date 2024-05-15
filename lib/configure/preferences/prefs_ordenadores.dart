import 'package:firebase_web/presentation/screens_widgets.dart';

class PreferenciasOrdenadores {
  static late SharedPreferences prefsO;

  static Future init() async {
    prefsO = await SharedPreferences.getInstance();
  }

  String get dono {
    return prefsO.getString('dono') ?? 'Nao dono';
  }

  set dono(String value) {
    prefsO.setString('dono', value);
  }

  String get memoriaRAM {
    return prefsO.getString('memoriaRAM') ?? 'Nao memoria ram';
  }

  set memoriaRAM(String value) {
    prefsO.setString('memoriaRAM', value);
  }

  String get periferico {
    return prefsO.getString('periferico') ?? 'Nao perifeirico';
  }

  set periferico(String value) {
    prefsO.setString('periferico', value);
  }

  String get procesador {
    return prefsO.getString('procesador') ?? 'Nao procesador';
  }

  set procesador(String value) {
    prefsO.setString('procesador', value);
  }

  String get serialNumber {
    return prefsO.getString('serialNumber') ?? 'Nao serialNumber';
  }

  set serialNumber(String value) {
    prefsO.setString('serialNumber', value);
  }

  String get imageURL {
    return prefsO.getString('imageURL') ?? 'Nao imageURL';
  }

  set imageURL(String value) {
    prefsO.setString('imageURL', value);
  }
  bool get disponible {
    return prefsO.getBool('disponible') ?? false;
  }

  set disponible(bool value) {
    prefsO.setBool('disponible', value);
  }
}
