import 'package:app/components/shadow_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../components/button.dart';
import '../icon_gallery.dart';
import '../localization.dart';

class RealtimePanel extends StatelessWidget {
  const RealtimePanel({super.key});

  static const _spacer = Spacer();
  static const _divisor = SizedBox(
    height: 10,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = localization(context);

    final line = Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      height: 3,
      color: theme.colorScheme.secondaryContainer,
    );

    return ShadowBox(
        child: Column(
      children: [
        _titleBar(theme, l10n),
        line,
        _histogram(theme, l10n),
        _largestEvents(theme, l10n),
        _spacer,
        GestureDetector(
          onTap: () {
            context.go('/');
          },
          child: Button(
            title: l10n.realtime_close,
          ),
        )
      ],
    ));
  }

  Widget _titleBar(ThemeData theme, AppLocalizations l10n) {
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

  Widget _histogram(ThemeData theme, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(l10n.realtime_histogram_title,
                    style: theme.textTheme.labelLarge),
              ),
              const Expanded(
                child: SizedBox(
                  height: 30,
                  child: Placeholder(),
                ),
              )
            ],
          ),
          _divisor,
          const SizedBox(
            height: 100,
            child: Placeholder(),
          ),
          _divisor,
          Text(
            l10n.realtime_select_region,
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(
            height: 40,
            child: Placeholder(),
          )
        ],
      ),
    );
  }

  Widget _largestEvents(ThemeData theme, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  l10n.realtime_the_largest,
                  style: theme.textTheme.labelLarge,
                )),
            const Expanded(
              child: SizedBox(
                height: 30,
                child: Placeholder(),
              ),
            )
          ],
        ),
        _divisor,
        const SizedBox(
          height: 300,
          child: Placeholder(),
        )
      ],
    );
  }
}
