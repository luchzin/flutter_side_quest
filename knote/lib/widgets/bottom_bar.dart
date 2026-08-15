import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knote/provider/file_provider.dart';
import 'package:knote/util/file.dart';

class Bottombar extends ConsumerWidget {
  const Bottombar({super.key});

  void newFile(BuildContext context, WidgetRef ref) {
    ref
        .read(fileManagerProvider.notifier)
        .createFile(
          parentId: 'root',
          name: 'New Note',
          language: FileLanguage.markdown,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.6),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _BottomBarOption(
                    icon: Icons.add_circle_outline_rounded,
                    label: "New Note",
                    onTap: () => newFile(context, ref),
                  ),
                  _BottomBarOption(icon: Icons.search_rounded, label: "Search", onTap: () {}),
                  _BottomBarOption(
                    icon: Icons.folder_open_rounded,
                    label: "Folders",
                    onTap: () {},
                  ),
                  _BottomBarOption(
                    icon: Icons.more_horiz_rounded,
                    label: "More",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomBarOption extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _BottomBarOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_BottomBarOption> createState() => _BottomBarOptionState();
}

class _BottomBarOptionState extends State<_BottomBarOption> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _isHovered
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? theme.colorScheme.primary.withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                scale: _isHovered ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Icon(widget.icon, color: color, size: 26),
              ),
              const SizedBox(height: 2),
              Text(
                widget.label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: _isHovered ? FontWeight.bold : FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
