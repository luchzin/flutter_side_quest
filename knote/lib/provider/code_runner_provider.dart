import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    try {
      final apiKey = dotenv.env['ONLINE_COMPILER_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('ONLINE_COMPILER_API_KEY is not configured');
      }
      final response = await http.post(
        Uri.parse('https://api.onlinecompiler.io/api/run-code-sync/'),
        headers: {'Authorization': apiKey, 'Content-Type': 'application/json'},
        body: jsonEncode({
          'compiler': compilerFor(file.$1),
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

String compilerFor(FileLanguage language) {
  switch (language) {
    case FileLanguage.python:
      return 'python-3.14';

    case FileLanguage.javascript:
      return 'nodejs';

    case FileLanguage.java:
      return 'java';

    case FileLanguage.c:
      return 'c';

    case FileLanguage.cpp:
      return 'cpp';

    default:
      throw UnsupportedError('Unsupported language: ${language.name}');
  }
}
