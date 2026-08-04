import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knote/provider/app_navigation_provider.dart';

import 'theme_dropdown.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentPageProvider);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 30, child: Icon(Icons.person, size: 35)),
                SizedBox(height: 10),
                Text(
                  "My App",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            selected: currentPage == AppPage.home,
            onTap: () {
              ref.read(currentPageProvider.notifier).state = AppPage.home;
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            selected: currentPage == AppPage.settings,
            onTap: () {
              ref.read(currentPageProvider.notifier).state = AppPage.settings;
              Navigator.pop(context);
            },
          ),

          const Divider(),

          const ThemeDropdown(),
        ],
      ),
    );
  }
}