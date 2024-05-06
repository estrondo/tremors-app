import 'package:app/components/footer.dart';
import 'package:app/components/shadow_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../components/button.dart';
import '../components/realtime_clock.dart';
import '../localization.dart';

class RealtimePanel extends StatelessWidget {
  const RealtimePanel({super.key});

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RealtimeClock(),
        line,
        ..._histogram(theme, l10n),
        _divisor,
        ..._largestEvents(theme, l10n),
        _divisor,
        Footer(children: [
          GestureDetector(
            onTap: () {
              context.go('/');
            },
            child: Button(
              title: l10n.realtime_close,
            ),
          )
        ])
      ],
    ));
  }

  List<Widget> _histogram(ThemeData theme, AppLocalizations l10n) {
    return [
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
    ];
  }

  List<Widget> _largestEvents(ThemeData theme, AppLocalizations l10n) {
    return [
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
      const Expanded(
        child: SizedBox(
          height: 300,
          child: Placeholder(),
        ),
      )
    ];
  }
}
