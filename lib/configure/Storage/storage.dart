import 'dart:io';
import 'package:firebase_web/presentation/screens_widgets.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final PreferenciasInventario prefs = PreferenciasInventario();

bool valueUploadImageProfile = false;
Future<bool> uploadImageProfile(File image, String path) async {
  final Reference ref = storage
      .ref()
      .child('dgaep')
      .child('inventario')
      .child(prefs.ultimoEscaneo);

  try {
    await ref.putFile(image);
    valueUploadImageProfile = true;
  } on FirebaseException catch (e) {
    print(e);
  }

  // var image_url = await ref.getDownloadURL();


  
  prefs.ultimaFotoSacada = await  ref.getDownloadURL();

  

  return valueUploadImageProfile;
}
