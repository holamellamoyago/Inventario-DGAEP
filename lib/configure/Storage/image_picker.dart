import 'package:firebase_web/presentation/screens_widgets.dart';

Future<XFile?> getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? file = await picker.pickMedia();

  return file;
}
