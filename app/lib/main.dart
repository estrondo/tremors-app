import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'components/background_map.dart';
import 'foundation.dart';
import 'router.dart';
import 'theme.dart';

void main() {
  final app = MaterialApp.router(
    color: Colors.redAccent,
    routerConfig: router(
        backgroundMap: const BackgroundMap(), topPanel: const RealtimeTopPanel()),
    theme: theme(),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate
    ],
    supportedLocales: const [Locale("en"), Locale("pt")],
  );

  runApp(AppTheme(
      shadowTheme: const ShadowTheme(offset: Offset(2, 2), blurRadius: 10),
      child: app));
}
