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

        const SizedBox(height: 24),
        const Text(
          "Editor",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 8),

        ListTile(
          leading: const Icon(Icons.text_fields_outlined),
          title: const Text("Font Size"),
          subtitle: const Text("14 px"),
          onTap: () {
            // TODO: Open font size picker
          },
        ),

        ListTile(
          leading: const Icon(Icons.wrap_text_outlined),
          title: const Text("Word Wrap"),
          subtitle: const Text("Wrap long lines"),
          trailing: Switch(
            value: true,
            onChanged: (value) {
              // TODO
            },
          ),
        ),

        ListTile(
          leading: const Icon(Icons.format_list_numbered),
          title: const Text("Line Numbers"),
          subtitle: const Text("Show line numbers"),
          trailing: Switch(
            value: true,
            onChanged: (value) {
              // TODO
            },
          ),
        ),

        ListTile(
          leading: const Icon(Icons.tab_outlined),
          title: const Text("Indentation"),
          subtitle: const Text("4 spaces"),
          onTap: () {
            // TODO: Open indentation settings
          },
        ),

        ListTile(
          leading: const Icon(Icons.code_outlined),
          title: const Text("Syntax Highlighting"),
          subtitle: const Text("Highlight code syntax"),
          trailing: Switch(
            value: true,
            onChanged: (value) {
              // TODO
            },
          ),
        ),

        const Divider(height: 32),

        const Text(
          "Files",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 8),

        ListTile(
          leading: const Icon(Icons.save_outlined),
          title: const Text("Auto Save"),
          subtitle: const Text("Automatically save changes"),
          trailing: Switch(
            value: true,
            onChanged: (value) {
              // TODO
            },
          ),
        ),

        ListTile(
          leading: const Icon(Icons.restore_outlined),
          title: const Text("Restore Open Files"),
          subtitle: const Text("Restore files when reopening the app"),
          trailing: Switch(
            value: true,
            onChanged: (value) {
              // TODO
            },
          ),
        ),

        ListTile(
          leading: const Icon(Icons.cleaning_services_outlined),
          title: const Text("Trim Trailing Whitespace"),
          subtitle: const Text("Remove whitespace when saving"),
          trailing: Switch(
            value: false,
            onChanged: (value) {
              // TODO
            },
          ),
        ),

        ListTile(
          leading: const Icon(Icons.history_outlined),
          title: const Text("Recent Files"),
          subtitle: const Text("Manage recently opened files"),
          onTap: () {
            // TODO
          },
        ),

        const Divider(height: 32),

        const Text(
          "Appearance",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 8),

        ListTile(
          leading: const Icon(Icons.dark_mode_outlined),
          title: const Text("Theme"),
          subtitle: const Text("System default"),
          onTap: () {
            // TODO: Theme picker
          },
        ),

        ListTile(
          leading: const Icon(Icons.view_agenda_outlined),
          title: const Text("Editor Density"),
          subtitle: const Text("Comfortable"),
          onTap: () {
            // TODO
          },
        ),

        ListTile(
          leading: const Icon(Icons.space_bar_outlined),
          title: const Text("Show Whitespace"),
          subtitle: const Text("Show spaces and tabs"),
          trailing: Switch(
            value: false,
            onChanged: (value) {
              // TODO
            },
          ),
        ),

        const Divider(height: 32),

        const Text(
          "Behavior",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 8),

        ListTile(
          leading: const Icon(Icons.format_align_left_outlined),
          title: const Text("Format on Save"),
          subtitle: const Text("Format supported files automatically"),
          trailing: Switch(
            value: false,
            onChanged: (value) {
              // TODO
            },
          ),
        ),

        ListTile(
          leading: const Icon(Icons.search_outlined),
          title: const Text("Search"),
          subtitle: const Text("Search and replace preferences"),
          onTap: () {
            // TODO
          },
        ),

        ListTile(
          leading: const Icon(Icons.keyboard_outlined),
          title: const Text("Keyboard Shortcuts"),
          subtitle: const Text("Customize editor shortcuts"),
          onTap: () {
            // TODO
          },
        ),

        const Divider(height: 32),

        const Text(
          "General",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 8),

        ListTile(
          leading: const Icon(Icons.notifications_outlined),
          title: const Text("Notifications"),
          trailing: Switch(value: true, onChanged: (value) {}),
        ),

        ListTile(
          leading: const Icon(Icons.language_outlined),
          title: const Text("Language"),
          subtitle: const Text("English"),
          onTap: () {},
        ),

        const Divider(height: 32),

        const Text(
          "About",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 8),

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
