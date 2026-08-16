import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:file_picker/file_picker.dart';
import 'package:knote/provider/quill_editor_provider.dart';
import 'package:knote/provider/code_runner_provider.dart';
import 'package:knote/provider/file_provider.dart';
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

  Future<void> _newFile(BuildContext context, WidgetRef ref) async {
    final newId = await ref
        .read(fileManagerProvider.notifier)
        .createFile(
          parentId: 'root',
          name: 'Untitled',
          language: FileLanguage.markdown,
        );
    ref.read(fileManagerProvider.notifier).select(newId);
  }

  Future<void> _openFile(BuildContext context, WidgetRef ref) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['c', 'cpp', 'java', 'py', 'js', 'ts', 'html', 'css', 'json', 'md', 'txt', 'dart'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final content = await file.readAsString();
      final name = result.files.single.name;
      final ext = result.files.single.extension ?? '';

      FileLanguage lang = FileLanguage.text;
      switch (ext.toLowerCase()) {
        case 'c': lang = FileLanguage.c; break;
        case 'cpp': lang = FileLanguage.cpp; break;
        case 'java': lang = FileLanguage.java; break;
        case 'py': lang = FileLanguage.python; break;
        case 'js': lang = FileLanguage.javascript; break;
        case 'ts': lang = FileLanguage.typescript; break;
        case 'html': lang = FileLanguage.html; break;
        case 'css': lang = FileLanguage.css; break;
        case 'json': lang = FileLanguage.json; break;
        case 'md': lang = FileLanguage.markdown; break;
        case 'dart': lang = FileLanguage.dart; break;
      }

      final newId = await ref
          .read(fileManagerProvider.notifier)
          .createFile(
            parentId: 'root',
            name: name,
            language: lang,
          );
      
      final doc = Document()..insert(0, content);
      ref.read(quillEditorProvider.notifier).loadDocument(doc);
      ref.read(fileManagerProvider.notifier).select(newId);
    }
  }

  void _showBottomSheet(BuildContext context, String content, {bool isError = false}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isError ? 'Error:' : 'Output:',
              style: TextStyle(
                color: isError ? Colors.red : Colors.white54,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(
                color: isError ? Colors.red : Colors.white,
                fontFamily: 'monospace',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(quillEditorProvider);
    final controller = ref.read(quillEditorProvider.notifier).controller;
    final codeRunnerState = ref.watch(codeRunnerProvider);

    ref.listen<AsyncValue<String?>>(codeRunnerProvider, (previous, next) {
      if (next is AsyncData && next.value != null && next.value != previous?.value) {
        _showBottomSheet(context, next.value!, isError: false);
      } else if (next is AsyncError && next.error != previous?.error) {
        _showBottomSheet(context, next.error.toString(), isError: true);
      }
    });

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
                  child: Row(
                    children: [
                      IconButton(
                        tooltip: 'New Note',
                        icon: const Icon(Icons.add_circle_outline_rounded),
                        onPressed: () => _newFile(context, ref),
                      ),
                      IconButton(
                        tooltip: 'Open File',
                        icon: const Icon(Icons.file_open_rounded),
                        onPressed: () => _openFile(context, ref),
                      ),
                      IconButton(
                        tooltip: 'Search',
                        icon: const Icon(Icons.search_rounded),
                        onPressed: () {},
                      ),
                      IconButton(
                        tooltip: 'More',
                        icon: const Icon(Icons.more_horiz_rounded),
                        onPressed: () {},
                      ),
                    ],
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
        if (codeRunnerState is AsyncLoading) const LinearProgressIndicator(),
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
      ],
    );
  }
}
