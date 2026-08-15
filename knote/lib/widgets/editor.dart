import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:knote/provider/quill_editor_provider.dart';
import 'package:knote/provider/code_runner_provider.dart';
import 'package:knote/util/file.dart';

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

  void _runCode(BuildContext context) {
    final controller = ref.read(quillEditorProvider.notifier).controller;
    final text = controller.document.toPlainText();
    ref
        .read(codeRunnerProvider.notifier)
        .runCode(
          file: (FileLanguage.python, text), // Defaulting to Python for now
          input: '',
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(quillEditorProvider);
    final controller = ref.read(quillEditorProvider.notifier).controller;
    final codeRunnerState = ref.watch(codeRunnerProvider);

    return Column(
      children: [
        if (!widget.readOnly)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QuillSimpleToolbar(
                    controller: controller,
                    config: const QuillSimpleToolbarConfig(
                      multiRowsDisplay: false,
                      showFontFamily: false,
                      showFontSize: false,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Run Code',
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.greenAccent,
                  ),
                  onPressed: () => _runCode(context),
                ),
              ],
            ),
          ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: QuillEditor.basic(
              controller: controller,
              config: const QuillEditorConfig(
                placeholder: 'Start typing code or notes...',
                padding: EdgeInsets.zero,
                expands: true,
              ),
              focusNode: _focusNode,
            ),
          ),
        ),
        if (codeRunnerState is AsyncLoading) const LinearProgressIndicator(),
        if (codeRunnerState is AsyncData && codeRunnerState.value != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black87,
              border: Border(
                top: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Output:',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  codeRunnerState.value!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        if (codeRunnerState is AsyncError)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.red.withOpacity(0.1),
            child: Text(
              'Error: ${codeRunnerState.error}',
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
