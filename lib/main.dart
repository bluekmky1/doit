import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes/app_router.dart';
import 'theme/doit_color_theme.dart';
import 'theme/doit_colors.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
        routerConfig: ref.watch(appRouterProvider).router,
        theme: ThemeData(
          scaffoldBackgroundColor: DoitColors.background,
          extensions: const <ThemeExtension<dynamic>>[
            DoitColorTheme.light,
          ],
        ),
      );
}
