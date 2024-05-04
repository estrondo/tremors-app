import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/button.dart';
import '../icon_gallery.dart';
import '../localization.dart';
import '../panel.dart';

class SearchPanel extends StatelessWidget {
  const SearchPanel({super.key});

  static const _fieldDivisorSize = 10.0;

  @override
  Widget build(BuildContext context) {
    final l10n = localization(context);
    final theme = Theme.of(context);
    return Panel(
      icon: IconGallery.search,
      title: l10n.search_title,
      content: Column(
        children: [
          _magnitudeRange(theme, l10n),
          _fieldHorizontalDivisor(),
          _magnitudeType(theme, l10n),
          _fieldHorizontalDivisor(),
          _stationCount(theme, l10n),
          _fieldHorizontalDivisor(),
          _evaluationMode(theme, l10n),
          _fieldHorizontalDivisor(),
          _evaluationStatus(theme, l10n),
          _fieldHorizontalDivisor(),
          _region(theme, l10n),
          _fieldHorizontalDivisor(),
          _savedSearches(theme, l10n)
        ],
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Button(
            title: l10n.search_cancel,
            width: 100,
          ),
          _fieldVerticalDivisor(),
          Button(
            title: l10n.search_apply,
            width: 100,
          )
        ],
      ),
    );
  }

  Widget _magnitudeRange(ThemeData theme, AppLocalizations l10n) {
    return _formField(theme, l10n.search_magnitude_range, _rangeInput());
  }

  Widget _magnitudeType(ThemeData theme, AppLocalizations l10n) {
    return _formField(theme, l10n.search_magnitude_type, _textField());
    ;
  }

  Widget _stationCount(ThemeData theme, AppLocalizations l10n) {
    return _formField(theme, l10n.search_station_count, _rangeInput());
  }

  Widget _evaluationMode(ThemeData theme, AppLocalizations l10n) {
    return _formField(theme, l10n.search_evaluation_mode, _textField());
  }

  Widget _evaluationStatus(ThemeData theme, AppLocalizations l10n) {
    return _formField(theme, l10n.search_evaluation_status, _textField());
  }

  _region(ThemeData theme, AppLocalizations l10n) {
    return _formField(theme, l10n.search_regions,
        const SizedBox(height: 150, child: Placeholder()));
  }

  _savedSearches(ThemeData theme, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.search_saved_searches,
          style: theme.textTheme.labelMedium,
        ),
        _fieldHorizontalDivisor(),
        const SizedBox(height: 80, child: Placeholder())
      ],
    );
  }

  _fieldHorizontalDivisor() {
    return const SizedBox(
      height: _fieldDivisorSize,
    );
  }

  _fieldVerticalDivisor() {
    return const SizedBox(
      width: _fieldDivisorSize,
    );
  }

  Widget _formField(ThemeData theme, String label, Widget content) {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: theme.textTheme.labelMedium,
            ),
          ),
          Expanded(flex: 2, child: content)
        ],
      ),
    );
  }

  Widget _textField() {
    return const SizedBox(
      width: 60,
      height: 30,
      child: Placeholder(),
    );
  }

  Widget _rangeInput() {
    return Row(
      children: [
        Expanded(child: _textField()),
        _fieldVerticalDivisor(),
        Expanded(child: _textField())
      ],
    );
  }
}
