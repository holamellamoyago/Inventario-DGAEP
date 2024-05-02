
import 'package:firebase_web/presentation/screens/inventario/ordenadores/crear_ordenadores_screen.dart';
import 'package:firebase_web/presentation/screens_widgets.dart';

final appRouter = GoRouter(
  initialLocation: '/home_screen', 
  routes: [
  GoRoute(
    path: '/login_screen',
    name: DashBoardScreen.name,
    builder: (context, state) => const DashBoardScreen(),
  ),
  GoRoute(
    path: '/home_screen',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/inventario_screen',
    name: InventoryScreen.name,
    builder: (context, state) => const InventoryScreen(),
  ),
  GoRoute(
    path: '/ordenadores_screen',
    name: OrdenadoresScreen.name,
    builder: (context, state) => const OrdenadoresScreen(),
  ),
  GoRoute(
    path: '/monitores_screen',
    name: MonitoresScreen.name,
    builder: (context, state) => const MonitoresScreen(),
  ),
  GoRoute(
    path: '/teclados_screen',
    name: TecladosScreen.name,
    builder: (context, state) => const TecladosScreen(),
  ),
  GoRoute(
    path: '/ratones_screen',
    name: RatonesScreen.name,
    builder: (context, state) => const RatonesScreen(),
  ),
  GoRoute(
    path: '/creacion_ordenadores_screen',
    name: CreacionOrdenadores.name,
    builder: (context, state) => const CreacionOrdenadores(),
  ),
]);
