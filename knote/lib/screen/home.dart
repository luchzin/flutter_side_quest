import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knote/provider/app_navigation_provider.dart';
import 'package:knote/provider/file_provider.dart';
import 'package:knote/screen/setting.dart';
import 'package:knote/widgets/editor.dart';
import 'package:knote/widgets/sidebar.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentPageProvider);
    final fileState = ref.watch(fileManagerProvider);
    final selectedNode = fileState.selectedNode;

    Widget titleWidget;
    if (selectedNode != null && currentPage == AppPage.home) {
      titleWidget = TextFormField(
        key: ValueKey(selectedNode.id),
        initialValue: selectedNode.name,
        style: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1.2, fontSize: 20),
        decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          suffixIcon: const Icon(Icons.edit_rounded, size: 18),
          suffixIconConstraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
        onFieldSubmitted: (value) {
          if (value.isNotEmpty) {
            ref.read(fileManagerProvider.notifier).rename(id: selectedNode.id, newName: value);
          }
        },
      );
    } else {
      titleWidget = Text(title, style: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1.2));
    }

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: titleWidget,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      drawer: const AppDrawer(),
      body: switch (currentPage) {
        AppPage.home => const QuillEditorComponent(),
        AppPage.settings => const SettingsPage(),
      },
    );
  }
}
