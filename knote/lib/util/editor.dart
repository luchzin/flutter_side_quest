class EditorFile {
  final String id;
  final String name;
  final String path;
  final String language;

  final String content;

  final bool isDirty;
  final bool isReadOnly;

  const EditorFile({
    required this.id,
    required this.name,
    required this.path,
    required this.language,
    required this.content,
    this.isDirty = false,
    this.isReadOnly = false,
  });

  EditorFile copyWith({String? content, bool? isDirty}) {
    return EditorFile(
      id: id,
      name: name,
      path: path,
      language: language,
      content: content ?? this.content,
      isDirty: isDirty ?? this.isDirty,
      isReadOnly: isReadOnly,
    );
  }
}

class EditorState {
  final List<EditorFile> openedFiles;

  final String? activeFileId;

  final bool loading;

  const EditorState({
    this.openedFiles = const [],
    this.activeFileId,
    this.loading = false,
  });

  EditorFile? get activeFile {
    try {
      return openedFiles.firstWhere((e) => e.id == activeFileId);
    } catch (_) {
      return null;
    }
  }

  EditorState copyWith({
    List<EditorFile>? openedFiles,
    String? activeFileId,
    bool? loading,
  }) {
    return EditorState(
      openedFiles: openedFiles ?? this.openedFiles,
      activeFileId: activeFileId ?? this.activeFileId,
      loading: loading ?? this.loading,
    );
  }
}
