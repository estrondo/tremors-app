import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations localization(BuildContext context) {
  return AppLocalizations.of(context)!;
}

String Function(BuildContext) intOf(
    String Function(AppLocalizations) builder) {
  return (context) => builder(AppLocalizations.of(context)!);
}
