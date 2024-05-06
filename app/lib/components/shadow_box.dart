import 'package:flutter/material.dart';

import '../theme.dart';

class ShadowBox extends StatelessWidget {
  final Widget child;

  const ShadowBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                offset: appTheme.shadowTheme.offset,
                blurRadius: appTheme.shadowTheme.blurRadius,
                color: theme.colorScheme.shadow)
          ]),
      child: child,
    );
  }
}
