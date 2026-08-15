import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knote/provider/app_navigation_provider.dart';

import 'theme_dropdown.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentPageProvider);
    final theme = Theme.of(context);

    return Drawer(
      backgroundColor: theme.drawerTheme.backgroundColor,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(24), bottomRight: Radius.circular(24)),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, left: 24, bottom: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(0.8),
                  theme.colorScheme.secondary.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 35, backgroundColor: Colors.white24, child: Icon(Icons.person, size: 40, color: Colors.white)),
                SizedBox(height: 16),
                Text(
                  "Knote Workspace",
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              leading: const Icon(Icons.home_rounded),
              title: const Text("Home", style: TextStyle(fontWeight: FontWeight.w500)),
              selected: currentPage == AppPage.home,
              selectedTileColor: theme.colorScheme.primary.withOpacity(0.15),
              selectedColor: theme.colorScheme.primary,
              onTap: () {
                ref.read(currentPageProvider.notifier).state = AppPage.home;
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              leading: const Icon(Icons.settings_rounded),
              title: const Text("Settings", style: TextStyle(fontWeight: FontWeight.w500)),
              selected: currentPage == AppPage.settings,
              selectedTileColor: theme.colorScheme.primary.withOpacity(0.15),
              selectedColor: theme.colorScheme.primary,
              onTap: () {
                ref.read(currentPageProvider.notifier).state = AppPage.settings;
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Divider(color: theme.dividerTheme.color),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: ThemeDropdown(),
          ),
        ],
      ),
    );
  }
}