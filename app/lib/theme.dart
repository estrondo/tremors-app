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

  const baseStyle = TextStyle(fontFamily: sourceSansPro, fontSize: 10);

  final boldAndItalic = baseStyle.copyWith(
      fontStyle: FontStyle.italic, fontWeight: FontWeight.w700);

  final italic = baseStyle.copyWith(fontStyle: FontStyle.italic);

  final textTheme = TextTheme(
      displayLarge: boldAndItalic.copyWith(fontSize: 20),
      displayMedium: italic.copyWith(fontSize: 14),
      displaySmall: baseStyle,
      headlineLarge: baseStyle,
      headlineMedium: boldAndItalic,
      headlineSmall: baseStyle,
      titleLarge: baseStyle,
      titleMedium: baseStyle,
      titleSmall: baseStyle,
      bodyLarge: baseStyle,
      bodyMedium: baseStyle,
      bodySmall: baseStyle,
      labelLarge: boldAndItalic.copyWith(fontSize: 14),
      labelMedium: italic.copyWith(fontSize: 12),
      labelSmall: baseStyle);

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
