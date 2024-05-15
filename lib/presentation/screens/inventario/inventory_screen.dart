import 'package:firebase_web/configure/preferences/prefs_inventario.dart';
import 'package:firebase_web/presentation/screens_widgets.dart';
import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  static const name = 'inventario_Screen';
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String text = 'No hay nada';

  @override
  Widget build(BuildContext context) {
    final subtitleStyleMedium = Theme.of(context).textTheme.bodyMedium;
    // String text = '';
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Inventario', style: TextStyle(fontWeight: FontWeight.bold),), centerTitle: true, ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            Text(
              'Añade o elimina los articulos que necesites',
              style: subtitleStyleMedium,
            ),
            _Espaciador(
              size: size,
              ancho: 60,
              altura: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: MenuContainer(
                      size: size,
                      icono: Icons.add,
                    ),
                  ),
                  GestureDetector(
                    child: MenuContainer(
                      size: size,
                      icono: Icons.remove,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: appMenuInventory.length,
                itemBuilder: (context, index) {
                  final _menuIndex = appMenuInventory[index];
                  return ListTile(
                    onTap: () => context.push(_menuIndex.link),
                    title: Text(_menuIndex.title),
                    subtitle: Text(_menuIndex.subtitle),
                    leading: Icon(_menuIndex.icon),
                    trailing: const Icon(Icons.arrow_forward_rounded),
                  );
                },
              ),
            ),
            Positioned(
                child: Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    bottom: 50,
                    child: FloatingActionButton(
                      onPressed: () => scannerQR(),
                      child: const Icon(Icons.qr_code_2),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Future<void> scannerQR() async {
    var prefs = PreferenciasInventario();
    String barcodeScanRes;
    var status = await Permission.camera.request();

    status.isDenied
        ? showSnackBar(context, 'Permiso denegado')
        : showSnackBar(context, 'Permiso concedido');

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", 'Cancelar', true, ScanMode.QR);
      prefs.ultimoEscaneo = barcodeScanRes;
    } catch (e) {
      showSnackBar(context, 'Ocurrio un mensaje en la lectura del código QR');
      prefs.ultimoEscaneo = 'No tenho código';
      context.go('/articulo_screen');
      return;
    }

    setState(() {
      text = barcodeScanRes;
    });

    prefs.ultimoEscaneo = barcodeScanRes;

    prefs.ultimoEscaneo != null
        ? context.push('/articulo_screen')
        : showSnackBar(context, 'Hubo un error');
  }
}

class _Espaciador extends StatelessWidget {
  const _Espaciador(
      {super.key,
      required this.size,
      required this.ancho,
      required this.altura});

  final Size size;
  final double ancho;
  final double altura;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ancho, vertical: altura),
      child: Container(
        color: Colors.black,
        height: 1,
      ),
    );
  }
}
