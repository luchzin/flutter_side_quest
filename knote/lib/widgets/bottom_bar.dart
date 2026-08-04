import 'package:flutter/material.dart';

class Bottombar extends StatelessWidget {
  const Bottombar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _BottomBarOption(icon: Icons.add, label: "New Note", onTap: () {}),
            _BottomBarOption(icon: Icons.search, label: "Search", onTap: () {}),
            _BottomBarOption(
              icon: Icons.folder_outlined,
              label: "Folders",
              onTap: () {},
            ),
            _BottomBarOption(
              icon: Icons.more_horiz,
              label: "More",
              onTap: () {},
            ),
          ],
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
    final color = _isHovered
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(widget.label, style: TextStyle(color: color, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
