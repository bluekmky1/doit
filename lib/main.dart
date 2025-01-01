import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes/app_router.dart';
import 'service/supabase_service.dart';
import 'theme/doit_color_theme.dart';
import 'theme/doit_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // .env 파일 로드
  await dotenv.load();

  // Supabase 초기화
  await SupabaseService.initialize();

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
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
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[
          Locale('ko', 'KR'),
        ],
      );
}
