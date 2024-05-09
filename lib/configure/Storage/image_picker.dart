import 'package:firebase_web/presentation/screens_widgets.dart';

Future<XFile?> getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? file = await picker.pickImage(source: ImageSource.camera, imageQuality: 1 );

  return file;
}
