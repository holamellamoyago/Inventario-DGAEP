import 'package:firebase_web/configure/Menu/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldkey;

  const SideMenu(
  {
    super.key, 
    required this.scaffoldkey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(
          () {
            navDrawerIndex = value;
          },
        );

        final menuItem = appMenuItems[value];
        context.push(menuItem.link);
        widget.scaffoldkey.currentState?.closeDrawer();
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
          child: const Text('Main'),
        ),
        ...appMenuItems.sublist(0,2).map(
              (item) => NavigationDrawerDestination(
                  icon: Icon(item.icon), label: Text(item.title)),
            ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 20, 16, 10),
          child: Text('More Options'),
        ),
        ...appMenuItems.sublist(0, appMenuItems.length).map(
              (item) => NavigationDrawerDestination(
                  icon: Icon(item.icon), label: Text(item.title)),
            ),
      ],
    );
  }
}
