import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knote/util/editor.dart';

final editorProvider =
    NotifierProvider<EditorNotifier, EditorState>(
  EditorNotifier.new,
);


class EditorNotifier extends Notifier<EditorState> {

  @override
  EditorState build() {
    return const EditorState();
  }

  void openFile(EditorFile file) {
    final exists = state.openedFiles.any((e) => e.id == file.id);

    if (exists) {
      state = state.copyWith(
        activeFileId: file.id,
      );
      return;
    }

    state = state.copyWith(
      openedFiles: [
        ...state.openedFiles,
        file,
      ],
      activeFileId: file.id,
    );
  }

  void closeFile(String id) {
    final files = [...state.openedFiles]
      ..removeWhere((e) => e.id == id);

    state = state.copyWith(
      openedFiles: files,
      activeFileId:
          files.isEmpty ? null : files.last.id,
    );
  }

  void switchFile(String id) {
    state = state.copyWith(
      activeFileId: id,
    );
  }

  void updateContent(String content) {
    final id = state.activeFileId;
    if (id == null) return;

    final files = state.openedFiles.map((e) {
      if (e.id != id) return e;

      return e.copyWith(
        content: content,
        isDirty: true,
      );
    }).toList();

    state = state.copyWith(
      openedFiles: files,
    );
  }

  void saveCurrent() {
    final id = state.activeFileId;
    if (id == null) return;

    final files = state.openedFiles.map((e) {
      if (e.id != id) return e;

      return e.copyWith(
        isDirty: false,
      );
    }).toList();

    state = state.copyWith(
      openedFiles: files,
    );
  }
}