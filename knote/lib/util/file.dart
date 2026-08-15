class FileManagerState {
  const FileManagerState({
    this.nodes = const [],
    this.selectedId,
    this.expandedFolderIds = const {},
    this.loading = false,
    this.error,
  });
  final List<ProjectNode> nodes;
  final String? selectedId;
  final Set<String> expandedFolderIds;
  final bool loading;
  final String? error;
  FileManagerState copyWith({
    List<ProjectNode>? nodes,
    String? selectedId,
    Set<String>? expandedFolderIds,
    bool? loading,
    String? error,
  }) {
    return FileManagerState(
      nodes: nodes ?? this.nodes,
      selectedId: selectedId ?? this.selectedId,
      expandedFolderIds: expandedFolderIds ?? this.expandedFolderIds,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  ProjectNode? get selectedNode {
    for (final node in nodes) {
      if (node.id == selectedId) {
        return node;
      }
    }
    return null;
  }
}

sealed class ProjectNode {
  const ProjectNode({
    required this.id,

    required this.name,

    required this.path,

    required this.parentId,
  });

  final String id;

  final String name;

  final String path;

  final String? parentId;

  ProjectNode copyWith({String? name});
}

class ProjectFile extends ProjectNode {
  const ProjectFile({
    required super.id,

    required super.name,

    required super.path,

    required super.parentId,

    required this.language,
  });

  final FileLanguage language;

  @override
  ProjectFile copyWith({String? name}) {
    return ProjectFile(
      id: id,

      name: name ?? this.name,

      path: path,

      parentId: parentId,

      language: language,
    );
  }
}

class ProjectFolder extends ProjectNode {
  const ProjectFolder({
    required super.id,

    required super.name,

    required super.path,

    required super.parentId,
  });

  @override
  ProjectFolder copyWith({String? name}) {
    return ProjectFolder(
      id: id,

      name: name ?? this.name,

      path: path,

      parentId: parentId,
    );
  }
}

enum FileLanguage {
  dart,

  cpp,

  c,

  java,

  python,

  javascript,

  typescript,

  html,

  css,

  json,

  markdown,

  text;

  String get compiler {
    switch (this) {
      case FileLanguage.javascript:
        return 'nodejs';
      case FileLanguage.python:
        return 'python-3.14';
      case FileLanguage.dart:
        return 'dart-main';
      case FileLanguage.typescript:
        return 'typescript-5';
      case FileLanguage.cpp:
        return 'g++';
      case FileLanguage.java:
        return 'java-21';
      default:
        return 'unknown';
    }
  }
}
