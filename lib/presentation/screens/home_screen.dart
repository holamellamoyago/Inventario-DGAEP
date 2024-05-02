import 'package:firebase_web/presentation/screens_widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // final uiProvider = Provider.of<UiProvider>(context);
    // final currentIndex = uiProvider.seleccionMenu;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('INVENTARIO DGAEP'),
      ),
      drawer: SideMenu(scaffoldkey: scaffoldKey),
      body: Expanded(
        child: ListView.builder(
          itemCount: appMenuItems.length,
          itemBuilder: (context, index) {
            final menuIndex = appMenuItems[index];
            return ListTile(
              leading: Icon(menuIndex.icon),
              trailing: const Icon(Icons.arrow_forward),
              title: Text(menuIndex.title),
              subtitle: Text(menuIndex.subtitle),

              onTap: () => context.push(menuIndex.link),
            );
          },
        ),
      ),
      // bottomNavigationBar: _BottomBar(uiProvider: uiProvider, currentIndex: currentIndex),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    super.key,
    required this.uiProvider,
    required this.currentIndex,
  });

  final UiProvider uiProvider;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // onTap: (value) => uiProvider.seleccionMenu = index, //AAREGLAR
      currentIndex: currentIndex,
      items: [],
    );
  }
}
