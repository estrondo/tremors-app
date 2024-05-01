import 'package:app/theme/default_shadow_theme.dart';
import 'package:flutter/material.dart';

class DefaultTheme extends InheritedWidget {
  final DefaultShadowTheme shadowTheme;

  const DefaultTheme(
      {super.key, required super.child, required this.shadowTheme});

  static DefaultTheme of(BuildContext context) {
    var theme = context.dependOnInheritedWidgetOfExactType<DefaultTheme>();
    assert(theme != null, 'No DefaultTheme in the context!');
    return theme!;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
