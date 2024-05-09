import 'dart:io';

import 'package:firebase_web/presentation/screens_widgets.dart';
import 'package:flutter/material.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final PreferenciasInventario prefs = PreferenciasInventario();

bool value = false;
Future<bool> uploadImageProfile(File image, String path) async {
  final Reference ref = storage
      .ref()
      .child('dgaep')
      .child('inventario')
      .child(prefs.ultimoEscaneo);

  try {
    await ref.putFile(image);
    value = true;
  } on FirebaseException catch (e) {
    print(e);
  }

  // var image_url = await ref.getDownloadURL();


  
  prefs.ultimaFotoSacada = await  ref.getDownloadURL();

  

  return value;
}
