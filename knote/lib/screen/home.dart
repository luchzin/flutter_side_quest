import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knote/provider/app_navigation_provider.dart';
import 'package:knote/screen/setting.dart';
import 'package:knote/widgets/bottom_bar.dart';
import 'package:knote/widgets/editor.dart';
import 'package:knote/widgets/sidebar.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentPageProvider);

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1.2)),
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      drawer: const AppDrawer(),
      body: switch (currentPage) {
        AppPage.home => const QuillEditorComponent(),
        AppPage.settings => const SettingsPage(),
      },
      bottomNavigationBar: const Bottombar(),
    );
  }
}
