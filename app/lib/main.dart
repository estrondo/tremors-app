import 'package:flutter/material.dart';

import 'components/background_map.dart';
import 'foundation.dart';
import 'router.dart';
import 'theme.dart';

void main() {
  final app = MaterialApp.router(
    color: Colors.redAccent,
    routerConfig: router(
        backgroundMap: const BackgroundMap(),
        topPanel: const RealtimePanel()),
    theme: theme(),
  );

  runApp(AppTheme(
      shadowTheme: const ShadowTheme(offset: Offset(2, 2), blurRadius: 10),
      child: app));
}
