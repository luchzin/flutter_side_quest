import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:knote/util/file.dart';

final codeRunnerProvider =
    NotifierProvider<CodeRunnerNotifier, AsyncValue<String?>>(
      CodeRunnerNotifier.new,
    );

class CodeRunnerNotifier extends Notifier<AsyncValue<String?>> {
  @override
  AsyncValue<String?> build() {
    return const AsyncData(null);
  }

  Future<void> runCode({
    required (FileLanguage language, String content) file,
    required String input,
  }) async {
    state = const AsyncLoading();

    const apiKey = '49dcb797e79a25906ed11464fc5ca0bd';

    try {
      final response = await http.post(
        Uri.parse('https://api.onlinecompiler.io/api/run-code-sync/'),
        headers: {'Authorization': apiKey, 'Content-Type': 'application/json'},
        body: jsonEncode({
          'compiler': compilerFor(file.$1.toString()),
          'code': file.$2,
          'input': input,
        }),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }

      state = AsyncData(response.body);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

String compilerFor(String language) {
  switch (language.toLowerCase()) {
    case 'python':
      return 'python-3.14';

    case 'javascript':
      return 'nodejs';

    case 'java':
      return 'java';

    case 'c':
      return 'c';

    case 'cpp':
      return 'cpp';

    default:
      throw UnsupportedError('Unsupported language: $language');
  }
}
