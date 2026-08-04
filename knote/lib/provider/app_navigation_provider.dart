import 'package:flutter_riverpod/legacy.dart';

enum AppPage { home, settings }

final currentPageProvider = StateProvider<AppPage>((ref) => AppPage.home);