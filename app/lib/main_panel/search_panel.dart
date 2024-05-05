import 'package:flutter/material.dart' hide Form, FormField;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/button.dart';
import '../components/form.dart';
import '../icon_gallery.dart';
import '../localization.dart';
import '../panel.dart';

class SearchPanel extends StatelessWidget {
  const SearchPanel({super.key});

  static const _divisor = SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    final l10n = localization(context);
    final theme = Theme.of(context);

    const placeHolder = Placeholder();
    return Panel(
      icon: IconGallery.search,
      title: l10n.search_title,
      content: Column(
        children: [
          Form(
            title: l10n.search_title,
            entries: [
              FormEntry(l10n.search_magnitude_range, placeHolder, placeHolder),
              FormEntry(l10n.search_magnitude_type, placeHolder, placeHolder),
              FormEntry(l10n.search_station_count, placeHolder, placeHolder),
              FormEntry(l10n.search_evaluation_mode, placeHolder, placeHolder),
              FormEntry(
                  l10n.search_evaluation_status, placeHolder, placeHolder),
              FormEntry(l10n.search_regions, placeHolder, placeHolder)
            ],
          ),
          _divisor,
          _savedSearches(theme, l10n)
        ],
      ),
      footer: FormFooter(
        children: [
          Button(title: l10n.search_apply)
        ],
      ),
    );
  }

  _savedSearches(ThemeData theme, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.search_saved_searches,
          style: theme.textTheme.labelMedium,
        ),
        _divisor,
        const SizedBox(height: 80, child: Placeholder())
      ],
    );
  }
}
