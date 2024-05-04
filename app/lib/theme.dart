import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final textTheme = TextTheme(
      titleLarge: GoogleFonts.sourceCodePro()
          .copyWith(fontSize: 17, fontWeight: FontWeight.bold),
      titleSmall: GoogleFonts.sourceCodePro().copyWith(fontSize: 12));

  final colorScheme = ColorScheme.fromSeed(seedColor: Colors.white).copyWith(
      shadow: Colors.black.withOpacity(0.3),
      secondaryContainer: const Color.fromARGB(0xff, 0xec, 0xee, 0xf2),
      primary: const Color.fromARGB(0xff, 0x00, 0x84, 0xff));

  return ThemeData(textTheme: textTheme, colorScheme: colorScheme);
}
