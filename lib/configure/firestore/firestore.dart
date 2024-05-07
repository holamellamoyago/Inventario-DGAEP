import 'package:firebase_web/presentation/screens_widgets.dart';

class DataBaseMethods {
  Future<Stream<QuerySnapshot>> getOrdenadoresDetails() async {
    return await FirebaseFirestore.instance
        .collection('dgaep')
        .doc('inventario')
        .collection('Ordenadores')
        .snapshots();
  }


  // Future<Map<String, dynamic>> getOrdenadoresDisponibles() async {
  //   return await FirebaseFirestore.instance
  //       .collection('dgaep')
  //       .doc('inventario')
  //       .collection('ordenadores')
  //       .where((event) => "ocupado" == false);
  // }
}
