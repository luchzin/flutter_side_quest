import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knote/provider/app_navigation_provider.dart';
import 'package:knote/screen/setting.dart';
import 'package:knote/widgets/editor.dart';
import 'package:knote/widgets/sidebar.dart';
class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentPageProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const AppDrawer(),
      body: switch (currentPage) {
        AppPage.home => QuillEditorComponent(),
        AppPage.settings => const SettingsPage(),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}