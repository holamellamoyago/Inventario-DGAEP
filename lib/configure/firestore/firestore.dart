import 'package:firebase_web/presentation/screens_widgets.dart';

class DataBaseMethods {
  Future<Stream<QuerySnapshot>> getOrdenadoresDetails() async {
    return await FirebaseFirestore.instance
        .collection('dgaep')
        .doc('inventario')
        .collection('Ordenador')
        .snapshots();
  }

}
