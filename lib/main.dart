import 'package:firebase_web/configure/preferences/prefs_inventario.dart';
import 'package:firebase_web/presentation/screens_widgets.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await PreferenciasInventario.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp();

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UiProvider(),
        ),
        // ChangeNotifierProvider(create: (_) => OrdenadoresProvider())
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
      ),
    );
  }
}
