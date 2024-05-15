import 'package:firebase_web/presentation/screens_widgets.dart';

class PreferenciasOrdenadores{
  static late SharedPreferences prefsO;

  static Future init() async {
    prefsO = await SharedPreferences.getInstance();
  }

    String get dono {
    return prefsO.getString('dono') ?? '999';
  }

  set dono(String value) {
    prefsO.setString('dono', value);
  }

}