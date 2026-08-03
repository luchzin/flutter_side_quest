import 'package:flutter/material.dart';

import 'theme_dropdown.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
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
