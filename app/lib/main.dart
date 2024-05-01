import 'package:app/components/background_map.dart';
import 'package:app/router.dart';
import 'package:app/theme/default_shadow_theme.dart';
import 'package:app/theme/default_theme.dart';
import 'package:flutter/material.dart';

void main() {
  final app = MaterialApp.router(
    color: Colors.redAccent,
    routerConfig: router(const BackgroundMap()),
    theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white).copyWith(
            shadow: Colors.black.withOpacity(0.3),
            secondaryContainer: Colors.pink,
            primary: const Color.fromARGB(0xff, 0x00, 0x84, 0xff))),
  );

  runApp(DefaultTheme(
      shadowTheme:
          const DefaultShadowTheme(offset: Offset(4, 4), blurRadius: 2),
      child: app));
}
