import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knote/util/file.dart';




final fileManagerProvider =
    NotifierProvider<FileManagerNotifier, FileManagerState>(
  FileManagerNotifier.new,
);


class FileManagerNotifier extends Notifier<FileManagerState> {

  @override
  FileManagerState build() {
    return const FileManagerState();
  }


  Future<void> loadWorkspace() async {
    state = state.copyWith(
      loading: true,
    );


    state = state.copyWith(
      loading: false,
    );
  }


  void select(String id) {
    state = state.copyWith(
      selectedId: id,
    );
  }


  void expandFolder(String id) {
    state = state.copyWith(
      expandedFolderIds: {
        ...state.expandedFolderIds,
        id,
      },
    );
  }


  void collapseFolder(String id) {
    final folders = {...state.expandedFolderIds};

    folders.remove(id);

    state = state.copyWith(
      expandedFolderIds: folders,
    );
  }


  void toggleFolder(String id) {
    if (state.expandedFolderIds.contains(id)) {
      collapseFolder(id);
    } else {
      expandFolder(id);
    }
  }


  Future<void> createFile({
    required String parentId,
    required String name,
    required FileLanguage language,
  }) async {

    final file = ProjectFile(
      id: DateTime.now().toString(),
      name: name,
      path: "$parentId/$name",
      parentId: parentId,
      language: language,
    );


    state = state.copyWith(
      nodes: [
        ...state.nodes,
        file,
      ],
    );
  }



  Future<void> createFolder({
    required String parentId,
    required String name,
  }) async {

    final folder = ProjectFolder(
      id: DateTime.now().toString(),
      name: name,
      path: "$parentId/$name",
      parentId: parentId,
    );


    state = state.copyWith(
      nodes: [
        ...state.nodes,
        folder,
      ],
    );
  }



  Future<void> rename({
    required String id,
    required String newName,
  }) async {

    final updated = state.nodes.map((node){

      if(node.id != id) return node;

      return node.copyWith(
        name: newName,
      );

    }).toList();


    state = state.copyWith(
      nodes: updated,
    );
  }



  Future<void> delete(String id) async {

    state = state.copyWith(
      nodes: state.nodes
          .where((e)=> e.id != id)
          .toList(),
    );
  }



  Future<void> move({
    required String id,
    required String targetFolderId,
  }) async {
    final updated = state.nodes.map((node) {
      if (node.id != id) return node;

      String newPath = targetFolderId == 'root' ? node.name : '$targetFolderId/${node.name}';
      
      if (node is ProjectFolder) {
        return node.copyWith(
          name: node.name,
        ) as ProjectNode; // The copyWith needs to handle path/parentId but ProjectNode copyWith only has name in the interface.
        // Wait, the ProjectFolder copyWith only has name? Let's just create a new one.
      }
      return node; // We can't update path and parentId via copyWith because it's not exposed!
    }).toList();

    // Since ProjectNode copyWith only exposes `name`, we should rebuild the object.
    final rebuilt = state.nodes.map((node) {
      if (node.id != id) return node;
      
      final newPath = targetFolderId == 'root' ? node.name : '$targetFolderId/${node.name}';
      
      if (node is ProjectFile) {
        return ProjectFile(
          id: node.id,
          name: node.name,
          path: newPath,
          parentId: targetFolderId,
          language: node.language,
        );
      } else if (node is ProjectFolder) {
        return ProjectFolder(
          id: node.id,
          name: node.name,
          path: newPath,
          parentId: targetFolderId,
        );
      }
      return node;
    }).toList();

    state = state.copyWith(
      nodes: rebuilt,
    );
  }

  Future<void> refresh() async {
    state = state.copyWith(loading: true);
    await Future.delayed(const Duration(milliseconds: 500));
    // In-memory refresh just re-emits current state, but typically this would load from DB/Storage.
    state = state.copyWith(loading: false);
  }
}
