import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../auth_notifier.dart';

class RootScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const RootScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    final isSeller = authNotifier.isSeller;

    final items = [
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.red,
        ),
        label: 'Catalog',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.chat,
          color: Colors.red,
        ),
        label: 'Chats',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.shopping_cart,
          color: Colors.red,
        ),
        label: 'Cart',
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: Colors.red,
        ),
        label: 'Profile',
      ),
    ];

    if (isSeller) {
      items.add(
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.store,
            color: Colors.red,
          ),
          label: 'Seller',
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: (index) {
            navigationShell.goBranch(index);
          },
          items: items,
          showUnselectedLabels: true,
          selectedItemColor: Colors.blue, // Цвет текста для выбранного элемента
          unselectedItemColor: const Color.fromARGB(255, 185, 13, 13)),
    );
  }
}
