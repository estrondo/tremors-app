import 'package:flutter/material.dart' hide Form;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/button.dart';
import '../components/form.dart';
import '../icon_gallery.dart';
import '../localization.dart';
import '../panel.dart';

class SearchPanel extends StatelessWidget {
  const SearchPanel({super.key});

  static const _horizontalDivisor = SizedBox(height: 10);
  static const _verticalDivisor = SizedBox(width: 10);

  @override
  Widget build(BuildContext context) {
    final l10n = localization(context);
    final theme = Theme.of(context);
    return Panel(
      icon: IconGallery.search,
      title: l10n.search_title,
      content: Column(
        children: [
          Form(
            entries: [
              (l10n.search_magnitude_range, _magnitudeRange(theme)),
              (l10n.search_magnitude_type, _magnitudeType(theme)),
              (l10n.search_station_count, _stationCount(theme)),
              (l10n.search_evaluation_mode, _evaluationMode(theme)),
              (l10n.search_evaluation_status, _evaluationStatus(theme)),
              (l10n.search_regions, _regions(theme))
            ],
          ),
          _horizontalDivisor,
          _savedSearches(theme, l10n)
        ],
      ),
      footer: FormFooter(
        children: [
          Button(title: l10n.search_cancel),
          Button(title: l10n.search_apply)
        ],
      ),
    );
  }

  Widget _magnitudeRange(ThemeData theme) {
    return _range();
  }

  Widget _magnitudeType(ThemeData theme) {
    return const Placeholder();
  }

  Widget _stationCount(ThemeData theme) {
    return _range();
  }

  Widget _evaluationMode(ThemeData theme) {
    return const Placeholder();
  }

  Widget _evaluationStatus(ThemeData theme) {
    return const Placeholder();
  }

  Widget _regions(ThemeData theme) {
    return const SizedBox(height: 120, child: Placeholder());
  }

  Widget _range() {
    return const Row(
      children: [
        Expanded(child: Placeholder()),
        _verticalDivisor,
        Expanded(child: Placeholder())
      ],
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
        _horizontalDivisor,
        const SizedBox(height: 80, child: Placeholder())
      ],
    );
  }
}
