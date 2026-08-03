import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knote/provider/theme_provider.dart';

 

class ThemeDropdown extends ConsumerWidget {
  const ThemeDropdown({
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentTheme = ref.watch(themeProvider);


    return ListTile(
      leading: const Icon(Icons.palette),
      title: const Text("Theme"),

      trailing: DropdownButton<ThemeMode>(
        value: currentTheme,

        underline: const SizedBox(),

        items: const [

          DropdownMenuItem(
            value: ThemeMode.system,
            child: Text("System"),
          ),

          DropdownMenuItem(
            value: ThemeMode.light,
            child: Text("Light"),
          ),

          DropdownMenuItem(
            value: ThemeMode.dark,
            child: Text("Dark"),
          ),
        ],


        onChanged: (value) {

          if(value != null){

            ref
              .read(themeProvider.notifier)
              .changeTheme(value);

          }
        },
      ),
    );
  }
}