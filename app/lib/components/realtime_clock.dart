import 'package:flutter/material.dart';

import '../icon_gallery.dart';
import '../localization.dart';

class RealtimeClock extends StatelessWidget {

  static const _spacer = Spacer();

  const RealtimeClock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = localization(context);
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(
          l10n.realtime_title,
          style: theme.textTheme.headlineMedium,
        ),
        _spacer,
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Icon(
            IconGallery.dateTime,
            size: 20,
            color: theme.colorScheme.secondary,
          ),
        ),
        Text(
          "2024-01-04 04:12:22 UTC-03",
          style: theme.textTheme.headlineMedium,
        )
      ],
    );
  }
}