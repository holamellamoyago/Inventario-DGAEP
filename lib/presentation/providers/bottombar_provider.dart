import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _seleccionMenu = 0;

  int get seleccionMenu {
    return _seleccionMenu;
  }

  set selecionMenu(int i) {
    _seleccionMenu = i;

    notifyListeners();
  }
}

// class OrdenadoresProvider extends ChangeNotifier {
//   int _totalOrdenadores = 0;
//   Stream? ordenadoresStream;

//   getNumberOfPC() async {
//     ordenadoresStream = await DataBaseMethods().getOrdenadoresDetails();
//     notifyListeners();
//   }

//   int get numeroOrdenadores {
//     int getOrdenadores = 2;
//     StreamBuilder(
//       stream: ordenadoresStream,
//       builder: (context, snapshot) {
//         return snapshot.hasData
//             ? getOrdenadores == snapshot.data.docs.length
//             : 0;
//       },
//     );
//     notifyListeners();
//     return getOrdenadores;
//   }

//   set numeroOrdenadores(int getOrdenadores) {
//     _totalOrdenadores = getOrdenadores;
//     notifyListeners();
//   }
// }
