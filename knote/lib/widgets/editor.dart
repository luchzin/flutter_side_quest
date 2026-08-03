import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:knote/provider/quill_editor_provider.dart';

class QuillEditorComponent extends ConsumerStatefulWidget {
  final bool readOnly;

  const QuillEditorComponent({super.key, this.readOnly = false});

  @override
  ConsumerState<QuillEditorComponent> createState() =>
      _QuillEditorComponentState();
}

class _QuillEditorComponentState extends ConsumerState<QuillEditorComponent> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch so this widget rebuilds on document changes (e.g. live word count)
    ref.watch(quillEditorProvider);
    final controller = ref.read(quillEditorProvider.notifier).controller;

    return Column(
      children: [
        if (!widget.readOnly)
          QuillSimpleToolbar(
            controller: controller,
            config: const QuillSimpleToolbarConfig(
              multiRowsDisplay: false,
              showFontFamily: false,
              showFontSize: false,
            ),
          ),
        const Divider(height: 1),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: QuillEditor.basic(
              controller: controller,
              config: QuillEditorConfig(
                placeholder: 'Start writing...',
                padding: EdgeInsets.zero,
                expands: true, // 👈 add this
              ),
              focusNode: _focusNode,
            ),
          ),
        ),
      ],
    );
  }
}
