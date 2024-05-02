import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final String link;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subtitle,
      required this.link,
      required this.icon});
}

const appMenuItems = <MenuItem>[
  MenuItem(
      title: 'Manejo de inventario',
      subtitle: 'Añade , quita o modifica el inventario.',
      link: '/inventario_screen',
      icon: Icons.computer),
  MenuItem(
      title: 'Gestión de incidencias',
      subtitle: 'Atiende todos los tickets de los usuarios.',
      link: '/home_screen',
      icon: Icons.playlist_play_rounded),
  MenuItem(
      title: 'Gestión de usuarios',
      subtitle: 'Atiende todos los tickets de los usuarios.',
      link: '/home_screen',
      icon: Icons.person),
];

class MenuInventory {
  final String title;
  final String subtitle;
  final String link;
  final IconData icon;

  const MenuInventory(
      {required this.title,
      required this.subtitle,
      required this.link,
      required this.icon});
}

const appMenuInventory = <MenuInventory>[
  MenuInventory(
      title: 'Lista de ordenadores',
      subtitle: 'Lista de ordenadores',
      link: '/ordenadores_screen',
      icon: Icons.computer),
  MenuInventory(
      title: 'Lista de monitores',
      subtitle: 'Lista de monitores',
      link: '/monitores_screen',
      icon: Icons.tv),
  MenuInventory(
      title: 'Lista de teclados',
      subtitle: 'Lista de teclados',
      link: '/teclados_screen',
      icon: Icons.keyboard),
  MenuInventory(
      title: 'Lista de ratones',
      subtitle: 'Lista de ratones',
      link: '/ratones_screen',
      icon: Icons.mouse),

];
