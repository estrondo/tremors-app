import 'package:flutter/material.dart';

class AppTheme extends InheritedWidget {
  final ShadowTheme shadowTheme;

  const AppTheme({super.key, required super.child, required this.shadowTheme});

  static AppTheme of(BuildContext context) {
    var theme = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(theme != null, 'No DefaultTheme in the context!');
    return theme!;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

class ShadowTheme {
  final Offset offset;
  final double blurRadius;

  const ShadowTheme({required this.offset, required this.blurRadius});
}

ThemeData theme() {
  const sourceSansPro = 'Source Sans Pro';

  const textTheme = TextTheme(
      titleLarge: TextStyle(
          fontFamily: sourceSansPro,
          fontSize: 20,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w700),
      labelMedium: TextStyle(
          fontFamily: sourceSansPro, fontSize: 16, fontStyle: FontStyle.italic),
      labelLarge: TextStyle(
          fontFamily: sourceSansPro,
          fontSize: 18,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w700));

  final colorScheme = ColorScheme.fromSeed(seedColor: Colors.white).copyWith(
      shadow: Colors.black.withOpacity(0.3),
      secondaryContainer: const Color.fromARGB(0xff, 0xec, 0xee, 0xf2),
      primary: const Color.fromARGB(0xff, 0x00, 0x84, 0xff),
      tertiary: const Color.fromARGB(0xff, 0xd7, 0xd7, 0xda));

  return ThemeData(
      textTheme: textTheme,
      colorScheme: colorScheme,
      fontFamily: sourceSansPro);
}
