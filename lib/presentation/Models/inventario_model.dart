import 'package:firebase_web/presentation/screens_widgets.dart';

class Inventario {
  final String? dono;
  final String? memoriaRAM;
  final String? periferico;
  final String? procesador;
  final String? serialNumber;
  final String? imageURL;
  final bool? disponible;

  Inventario(
      {this.dono,
      this.memoriaRAM,
      this.periferico,
      this.procesador,
      this.serialNumber,
      this.imageURL,
      this.disponible
      });

  factory Inventario.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Inventario(
      dono: data?['Dono'],
      memoriaRAM: data?['Memoria_RAM'],
      periferico: data?['Periferico'],
      procesador: data?['Procesador'],
      serialNumber: data?['Serial_number'],
      imageURL: data?['image_url'],
      disponible: data?['Disponible']
    );
  }
  // TODO Queda hacer el toFirestore
  Map<String, dynamic> toFirestore() {
    return {if (dono != null) "Dono": dono};
  }
}
