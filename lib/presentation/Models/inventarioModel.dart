import 'package:firebase_web/presentation/screens_widgets.dart';

class Inventario {
  final String? dono;
  

  Inventario({this.dono});

  factory Inventario.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Inventario(dono: data?['Dono']);
  }

  Map<String, dynamic> toFirestore() {
    return {if (dono != null) "Dono": dono};
  }
}


