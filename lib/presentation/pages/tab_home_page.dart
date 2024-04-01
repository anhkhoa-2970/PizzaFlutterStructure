import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testxxxx/config/app_router.dart';

class TabHomePage extends StatelessWidget {

  const TabHomePage({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    if (index != navigationShell.currentIndex) {
      navigationShell.goBranch(
        index,
        // A common pattern when using bottom navigation bars is to support
        // navigating to the initial location when tapping the item that is
        // already active. This example demonstrates how to support this behavior,
        // using the initialLocation parameter of goBranch.
        initialLocation: index == navigationShell.currentIndex,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(label: 'Tab 1', icon: Icon(Icons.home)),
          NavigationDestination(label: 'Tab 2', icon: Icon(Icons.settings)),
          NavigationDestination(label: 'Tab 3', icon: Icon(Icons.notifications)),
        ],
        onDestinationSelected: _goBranch,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Drawer Header', style: TextStyle(color: Colors.white))),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.black),
              title: const Text("Tab1 Page", style: TextStyle(color: Colors.black)),
              onTap: () {
                _goBranch(0);
                scaffoldKey.currentState!.closeDrawer();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.black),
              title: const Text("Tab2 Page", style: TextStyle(color: Colors.black)),
              onTap: () {
                _goBranch(1);
                scaffoldKey.currentState!.closeDrawer();
              },
            ),
            ListTile(
              leading: const Icon(Icons.surround_sound, color: Colors.black),
              title: const Text("Tab3 Page", style: TextStyle(color: Colors.black)),
              onTap: () {
                _goBranch(2);
                scaffoldKey.currentState!.closeDrawer();
              },
            )
          ],
        ),
      ),
    );
  }
}
