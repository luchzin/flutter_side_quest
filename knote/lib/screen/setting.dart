import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "Settings",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        ListTile(
          leading: const Icon(Icons.notifications_outlined),
          title: const Text("Notifications"),
          trailing: Switch(
            value: true,
            onChanged: (value) {
              // TODO: hook up to a provider if you want this persisted
            },
          ),
        ),

        const Divider(),

        ListTile(
          leading: const Icon(Icons.dark_mode_outlined),
          title: const Text("Dark Mode"),
          trailing: Switch(
            value: false,
            onChanged: (value) {
              // TODO: hook up to your theme provider
            },
          ),
        ),

        const Divider(),

        ListTile(
          leading: const Icon(Icons.language_outlined),
          title: const Text("Language"),
          subtitle: const Text("English"),
          onTap: () {
            // TODO: open language picker
          },
        ),

        const Divider(),

        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text("About"),
          subtitle: const Text("Version 1.0.0"),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: "My App",
              applicationVersion: "1.0.0",
            );
          },
        ),
      ],
    );
  }
}
