import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';

final quillEditorProvider = NotifierProvider<QuillEditorNotifier, Document>(
  QuillEditorNotifier.new,
);

class QuillEditorNotifier extends Notifier<Document> {
  late QuillController controller;

  @override
  Document build() {
    controller = QuillController(
      document: Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );

    // Keep provider state in sync whenever the document changes
    controller.document.changes.listen((_) {
      state = controller.document;
    });

    ref.onDispose(() {
      controller.dispose();
    });

    return controller.document;
  }

  /// Load existing content, e.g. when opening a saved note
  void loadDocument(Document doc) {
    controller.document = doc;
    state = doc;
  }

  /// Clear the editor, e.g. after saving a new note
  void clear() {
    controller.clear();
    state = controller.document;
  }

  /// Get content as JSON string for persistence
  String toJson() {
    return controller.document.toDelta().toJson().toString();
  }
}
