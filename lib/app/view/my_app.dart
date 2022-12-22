import 'package:eczema/core/core.dart';
import 'package:eczema/core/theme/theme_notifier.dart';
import 'package:eczema/features/guess_nationality/presentation/view/guess_nationality_page.dart';
import 'package:eczema/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      navigatorObservers: [
        RouterObserver(),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      darkTheme: ThemeData.dark(),
      themeMode: themeMode ? ThemeMode.dark : ThemeMode.light,
      home: const GuessNationalityPage(),
    );
  }
}
